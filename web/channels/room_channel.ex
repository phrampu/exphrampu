defmodule Phrampu.RoomChannel do
  use Phoenix.Channel
  import Ecto.Query

  def join("room:phrampu", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", payload, socket) do
    broadcast! socket, "new_message", payload
    {:noreply, socket}
  end

  def ok(whos) do
    Enum.map(whos, fn (w) ->
      %{
        name: w.student.name,
        hostname: w.host.name,
        tty: w.tty,
        what: w.what
      }
    end)
  end

  def update_all() do
    whos = Phrampu.Who 
      |> Phrampu.Who.get_active_whos() 
      |> Ecto.Query.preload([:host])
      |> Ecto.Query.preload([:student])
      |> Phrampu.Repo.all
      |> ok
    Phrampu.Endpoint.broadcast("room:phrampu", "new_message", 
      %{
        "whos": whos
      })
  end

  def handle_in("send_data", payload, socket) do
    whos = Phrampu.Who 
      |> Phrampu.Who.get_active_whos() 
      |> Ecto.Query.preload([:host])
      |> Ecto.Query.preload([:student])
      |> Phrampu.Repo.all
      |> ok
    broadcast! socket, "new_message", %{whos: whos}
    {:noreply, socket}
  end

  def handle_out("new_message", payload, socket) do
    push socket, "new_message", payload
    {:noreply, socket}
  end
end
