defmodule Phrampu.WhoModule do
  alias Phrampu.Who

  def user do
    System.get_env("PHRAMPU_USERNAME")
  end

  def pass do
    System.get_env("PHRAMPU_PASSWORD")
  end

  def connect(ip) do
    :ssh.start
    SSHEx.connect(
    ip: ip,
    user: user(),
    password: pass())
  end

  def get_who(hostname) do
    case connect(hostname) do
      {:ok, conn} ->
        case w(conn) do
          {:ok, ret} ->
            {:ok, ret}
          error ->
            error
        end
      error ->
        error
    end
  end

  def w(conn) do
    case SSHEx.run conn, 'w' do
      {:ok, w_string, 0} ->
        {:ok, w_string}
      {:error, reason} ->
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

  def insert_whos(hostname, w_string) do
    w_string
    |> String.split("\n")
    |> Enum.slice(2..-1)
    |> Enum.filter(fn(x) -> x != "" end)
    |> Enum.each(fn(x) -> insert(hostname, x) end)
  end

  def insert(hostname, who_string) do
    [user, tty, login, idle, jcpu, pcpu | what] = String.split who_string
    Who.changeset(%Who{}, %{
      student_id: Phrampu.Repo.get_by!(Phrampu.Student, career_acc: user).id,
      host_id: Phrampu.Repo.get_by!(Phrampu.Host, name: hostname).id,
      tty: tty,
      is_tty: tty |> is_tty,
      is_idle: idle |> is_idle,
      login: login,
      idle: idle,
      jcpu: jcpu,
      pcpu: pcpu,
      what: what |> Enum.join(" ")
    }) |> Phrampu.Repo.insert!
  end
end
