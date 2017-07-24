defmodule Phrampu.RoomChannel do
  use Phoenix.Channel

  def join("phrampu", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", payload, socket) do
    broadcast! socket, "new_message", %{data: "fuck"}
    {:noreply, socket}
  end

  def handle_in("send_data", payload, socket) do
    #whos = Phrampu.Cluster 
      #|> Phrampu.Cluster.get_active_whos() 
      #|> Phrampu.Repo.all
    broadcast! socket, "new_message", %{data: "cocks"}
    {:noreply, socket}
  end
end
