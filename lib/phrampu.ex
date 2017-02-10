defmodule Phrampu do
  @moduledoc """
  Something
  """
  use GenServer
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def init(state) do
    {:ok, state}
  end

  def push(pid, item) do
    GenServer.cast(pid, {:push, item})
  end

  def who(pid, hostname) do
    GenServer.call(pid, {:who, hostname})
  end

  # Server (callbacks)

  def handle_call({:who, hostname}, _from, state) do
    thing = WhoModule.getWho(hostname)
      |> WhoModule.getStructs
    {:reply, thing, state}
  end

  def handle_call(request, from, state) do
    super(request, from, state)
  end

  def handle_cast({:push, item}, state) do
    {:noreply, [item | state]}
  end

  def handle_cast(request, state) do
    super(request, state)
  end
end
