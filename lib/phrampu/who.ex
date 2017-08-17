defmodule Phrampu.WhoModule do
  alias Phrampu.Who
  require Logger

  def user do
    System.get_env("PHRAMPU_USERNAME")
  end

  def pass do
    System.get_env("PHRAMPU_PASSWORD")
  end

  def connect(ip) do
    Logger.info "Connecting to #{ip}"
    case SSHEx.connect(
      ip: ip,
      user: user(),
      password: pass()) do
        {:ok, conn} ->
          Logger.info "Successfully connected to #{ip}"
          {:ok, conn}
        {:error, error} -> 
        # TODO retry 3 or 4 times after delay
          Logger.error "Couldn't connect to #{ip}, #{error}"
          {:error, error}
      end
  end

  def get_who(hostname) do
    case connect(hostname) do
      {:ok, conn} ->
        case w(conn) do
          {:ok, ret} ->
            {:ok, ret}
          {:error, error} ->
            Logger.error "couldn't connect to #{hostname}"
            {:error, error}
        end
      {:error, error} ->
        Logger.error "error in get_who: #{error}"
        {:error, error}
    end
  end

  def get_who!(hostname) do
    case get_who(hostname) do
      {:ok, ret} ->
        ret
      {:error, error} ->
        Logger.error "couldn't connect to #{hostname}, #{error}"
        error
      err ->
        Logger.error "couldn't connect to #{hostname}, #{err}"
    end
  end

  def w(conn) do
    case SSHEx.run conn, 'w' do
      {:ok, w_string, 0} ->
        {:ok, w_string}
      {:error, reason} ->
        Logger.error "couldn't 'w': #{reason}"
        {:error, reason}
    end
  end

  def is_tty(str) do
    String.contains?(str, "tty")
  end

  def mins(str) do
    [mins | _] = String.split(str, [":", "m"])
    mins |> Integer.parse |> elem(0)
  end

  # TODO Fix this code, use cond and not nested ifs
  def is_idle(str) do
    if String.contains?(str, "days") do
      true
    else
      if String.contains?(str, "s") do
        false
      else
        if String.contains?(str, "m") do
          if (mins(str) > 20) do
            true
          else
            false
          end
        else
          false
        end
      end
    end
  end

  def insert_whos(w_string, hostname) do
    sp = 
      w_string
      |> String.split("\n")

    contains_from = 
      sp
      |> Enum.at(1)
      |> String.contains?("FROM")

    sp
      |> Enum.slice(2..-1)
      |> Enum.filter(fn(x) -> x != "" end)
      |> Enum.each(fn(x) -> insert(hostname, x, contains_from) end)
  end

  def insert(hostname, who_string, contains_from) do
    case contains_from do
      true ->
        insert_with_from(hostname, who_string)
      false ->
        insert_without_from(hostname, who_string)
    end
  end

  def get_student_id(user) do
    case Phrampu.Repo.get_by(Phrampu.Student, career_acc: user) do
      nil ->
        Logger.error "couldn't find career acc '#{user}' in db"
        nil
      student ->
        IO.inspect student
        student.id
    end
  end

  def insert_with_from(hostname, who_string) do
    [user, tty, from, login, idle, jcpu, pcpu | what] = String.split who_string
    student_id = get_student_id user
    if student_id do
      %{
        student_id: student_id,
        host_id: Phrampu.Repo.get_by!(Phrampu.Host, name: hostname).id,
        tty: tty,
        from: from,
        is_tty: tty |> is_tty,
        is_idle: idle |> is_idle,
        login: login,
        idle: idle,
        jcpu: jcpu,
        pcpu: pcpu,
        what: what |> Enum.join(" ")
      } |> insert!()
    end
  end

  def insert_without_from(hostname, who_string) do
    [user, tty, login, idle, jcpu, pcpu | what] = String.split who_string
    student_id = get_student_id user
    if student_id do
      %{
        student_id: student_id,
        host_id: Phrampu.Repo.get_by!(Phrampu.Host, name: hostname).id,
        tty: tty,
        is_tty: tty |> is_tty,
        is_idle: idle |> is_idle,
        login: login,
        idle: idle,
        jcpu: jcpu,
        pcpu: pcpu,
        what: what |> Enum.join(" ")
      } |> insert!()
    end
  end

  def insert!(params) do
    # TODO use this way, where we store
    # ALL who entries, and don't just update
    # the same entry over and over,
    # losing all the old ones
    #%Who{}
    #|> Who.changeset(params) 
    #|> Phrampu.Repo.insert!

    # TODO FIX THIS HACK
    case Phrampu.Repo.get_by(Who,
      student_id: params.student_id,
      host_id: params.host_id,
      tty: params.tty) do
        nil -> %Who{}
        who -> who
      end
      |> Who.changeset(params) 
      |> Phrampu.Repo.insert_or_update

  end
end
