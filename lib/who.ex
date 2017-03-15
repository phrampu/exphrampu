defmodule WhoModule do
  @moduledoc """
  Documentation for Phrampu.
  """

  def connect(ip, user, password) do
    :ssh.start
    SSHEx.connect(
      ip: ip,
      user: user,
      password: password)
  end

  def get_who(ip) do
    ip2 = to_char_list(ip)
    pass = to_char_list(System.get_env("PHRAMPU_PASSWORD"))
    user = to_char_list(System.get_env("PHRAMPU_USERNAME"))
    get_who(ip2, user, pass)
  end

  def get_who(ip, user, password) do
    case connect(ip, user, password) do
      {:ok, conn} ->
        {:ok, w(conn)}
      {:error, reason} ->
        {:error, reason}
    end
  end

  def w(pid) do
    case SSHEx.run pid, 'w' do
      {:ok, wString, 0} ->
        {:ok, wString}
      {:error, reason} ->
        {:error, reason}
    end
  end

  def get_cluster(hostname) do
    [ name | _ ] = hostname |> to_string |> String.split(".")
    case String.slice(name, 0..1) do
      "bo" -> "borg"
      "po" -> "pod"
      "ta" -> "ta"
      "ss" -> "sslab"
      "mo" -> "moore"
      "es" -> "escher"
      "xi" -> "xinu"
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


  def get_structs(wOut) do
    wOut
      |> String.split("\n")
      |> Enum.slice(2..-1)
      |> Enum.filter_map(
         fn(x) -> x != "" end,
         fn(x) -> WhoStruct.from_string(x) end)
      |> Enum.filter(fn(struc) -> is_tty(struc.tty) end)
  end
end

defmodule WhoStruct do
  @moduledoc """
  Struct representing the contents of a single line of a call to 
  the unix command 'w'
  """
   defstruct user: nil,
             tty: nil,
             login: nil,
             idle: nil,
             jcpu: nil,
             pcpu: nil,
             what: nil

   def from_string(str) do
     [user, tty, login, idle, jcpu, pcpu | what] = String.split str
     %WhoStruct{
       user: user,
       tty: tty,
       login: login,
       idle: idle,
       jcpu: jcpu,
       pcpu: pcpu,
       what: what |> Enum.join(" ")
     }
   end
end
