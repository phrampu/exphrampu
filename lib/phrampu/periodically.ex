defmodule Phrampu.Periodically do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Jank.jank()
    {:ok, state}
  end

  def handle_info(:work, state) do
    Jank.jank()
    {:noreply, state}
  end

  defp schedule_work() do
    #  Process.send_after(self(), :work, 1 * 30 * 60 * 1000) # In 30 mins
     Process.send_after(self(), :work, 1 * 60 * 60 * 1000) # In 60 mins
  end
end
