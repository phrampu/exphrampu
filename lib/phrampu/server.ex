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
        :map => %{},
      }, name: ref(cluster))
  end

  def who(pid, host) do
    IO.puts "who"
    try do
      ret = GenServer.call(pid, {:who, host})
      IO.puts "ret:"
      IO.inspect ret
      ret
    catch
      :exit, reason -> 
        IO.puts "fuck"    
        {:error, reason}
    end
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
    IO.puts "handle_call :who"
    who = WhoModule.get_who(host)
    case who do
      {:error, reason} ->
        IO.puts "Server error handling :who:"
        IO.inspect reason
        {:reply, state, state}
      {:ok, whoList} ->
        IO.inspect whoList
        struct_list = whoList |> WhoModule.get_structs

        state_map = Map.put(state[:map], host, struct_list)
        state2 = Map.put(state, :map, state_map)

        {:reply, state2, state2}
      _ ->
        IO.puts "how the fuck"
    end
  end

  defp ref(cluster) do
    {:global, {:cluster, cluster}}
  end

  def refpid(cluster) do
    {:global, {:cluster, cluster}} |> GenServer.whereis()
  end
end
