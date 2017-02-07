defmodule Phrampu do
  @moduledoc """
  Documentation for Phrampu.
  """

  def connect(ip, password) do
    :ssh.start
    SSHEx.connect(
      ip: ip,
      user: 'schwar12', 
      password: password)
    #:ssh.connect(ip, 22, user: 'schwar12', password: password)
  end

  def getWho(ip) do
    getWho(ip, System.get_env("PHRAMPU_PASSWORD") |> String.to_char_list)
  end

  def getWho(ip, password) do
    case connect(ip, password) do
      {:ok, conn} -> 
        conn |> w
      {:error, reason} ->
        throw reason
    end
  end

  def w(pid) do
    SSHEx.run pid, 'w'
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
