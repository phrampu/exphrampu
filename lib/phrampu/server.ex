defmodule Phrampu.Server do
  @moduledoc """
  Main phrampu server. This module will
  keep a map in memory, and coordinate
  ssh clients
  """
  use GenServer

  # Client
  def create(cluster, urls) do
    case GenServer.whereis(ref(cluster)) do
      nil ->
        Supervisor.start_child(
          Phrampu.Server.Supervisor,
          [cluster, urls]
        )
      _ ->
        {:error, :cluster_already_started}
    end
  end

  def start_link(cluster, urls) do
    GenServer.start_link(__MODULE__,
      %{:cluster => cluster,
        :urls => urls,
        :map => urls
                  |> Enum.map(fn(x) -> %{x => []} end)
                  |> Enum.reduce(%{}, fn(map, acc) -> Map.merge(acc, map) end)
      }, name: ref(cluster))
  end

  def who(pid, host) do
    GenServer.call(pid, {:who, host})
  end

  def state(pid) do
    GenServer.call(pid, :state)
  end

  # Server (callbacks)
  def init(:ok, state) do
    {:ok, state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:get_pid, _from, state) do
    {:reply, self(), state}
  end

  # TODO: don't use try/catch
  def handle_call({:who, host}, _from, state) do
    who = WhoModule.getWho(host)
    struct_list = who
              |> WhoModule.getStructs

    state_map = Map.put(state[:map], host, struct_list)
    state2 = Map.put(state, :map, state_map)

    {:reply, state2, state2}
  end

  defp ref(cluster) do
    {:global, {:cluster, cluster}}
  end
end
