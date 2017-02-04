defmodule Phrampu do
  @moduledoc """
  Documentation for Phrampu.
  """

  def getWho(ip) do
    getWho(ip, System.get_env("PHRAMPU_PASSWORD"))
  end

  def getWho(ip, password) do
    {:ok, conn} = SSHEx.connect([
      ip: ip,
      user: "schwar12", 
      password: password])
    {:ok, res, 0} = SSHEx.run conn, "who"
    res
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

   def build(str) do
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
