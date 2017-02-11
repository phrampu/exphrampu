defmodule Phrampu do
  @moduledoc """
  Something
  """
  use GenServer

  # Client
  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def who(pid, hostname) do
    GenServer.call(pid, {:who, hostname})
  end

  def state(pid) do
    GenServer.call(pid, :state)
  end

  # Server (callbacks)
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:who, hostname}, _from, state) do
    cluster = WhoModule.getCluster(hostname)
    structList = WhoModule.getWho(hostname)
              |> WhoModule.getStructs

    thing = case Map.has_key?(state, cluster) do
      true ->
       [ Map.get(state, cluster) | %{hostname => structList} ]
      false ->
       [ %{hostname => structList} ]
    end
      
    state2 = Map.put(state, cluster, thing)
    {:reply, state2, state2}
  end

  def handle_call(request, from, state) do
    super(request, from, state)
  end
end
