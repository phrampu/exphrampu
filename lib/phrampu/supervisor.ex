# in lib/chat/supervisor.ex

defmodule Phrampu.Server.Supervisor do
  use Supervisor

  @name Phrampu.Server.Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def init(:ok) do
    children = [
      worker(
        Phrampu.Server, 
        [], 
        restart: :transient
      )
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
