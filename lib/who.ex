defmodule WhoModule do
  @moduledoc """
  Documentation for Phrampu.
  """

  def connect(ip, password) do
    :ssh.start
    SSHEx.connect(
      ip: ip,
      user: 'schwar12', 
      password: password)
  end

  def getWho(ip) do
    getWho(ip, System.get_env("PHRAMPU_PASSWORD") |> String.to_char_list)
  end

  def getWho(ip, password) do
    case connect(ip, password) do
      {:ok, conn} -> 
        conn 
          |> w
      {:error, reason} ->
        throw reason
    end
  end

  def w(pid) do
    case SSHEx.run pid, 'w' do
      {:ok, wString, 0} ->
        wString
      {:error, reason} ->
        throw reason
    end
  end

  def istty(str) do
    String.contains?(str, "tty")
  end

  def getStructs(wOut) do
    wOut
      |> String.split("\n")
      |> Enum.slice(2..-1)
      |> Enum.filter_map(
         fn(x) -> x != "" end,
         fn(x) -> WhoStruct.from_string(x) end)
  end
end

defmodule WhoStruct do
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
