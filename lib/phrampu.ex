defmodule Phrampu do
  @moduledoc """
  Main phrampu server. This module will
  keep a map in memory, and coordinate
  ssh clients
  """
  use GenServer

  # Client
  def start_link(cluster, urls) do
    GenServer.start_link(__MODULE__, 
      %{:cluster => cluster, 
        :urls => urls, 
        :map => %{}
      })
  end

  def who(pid, host) do
    GenServer.call(pid, {:who, host})
  end

  def state(pid) do
    GenServer.call(pid, :state)
  end

  # Server (callbacks)
  def init(:ok, state) do
    {:ok}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:who, host}, _from, state) do
    structList = WhoModule.getWho(host)
              |> WhoModule.getStructs

    stateMap = Map.put(state[:map], host, structList)
    state2 = Map.put(state, :map, stateMap)

    {:reply, state2, state2}
  end
end
