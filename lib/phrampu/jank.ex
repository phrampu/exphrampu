defmodule Jank do
  alias Phrampu.Host
  alias Phrampu.Repo
  require Logger

  def jank() do
    Host
      |> Repo.all 
      |> Enum.map(fn(c) -> c.name end) 
      |> Enum.map(fn(h) -> spawn_link fn -> (
        case Phrampu.WhoModule.get_who(h) do 
          {:ok, ret} -> 
            ret |> Phrampu.WhoModule.insert_whos(h)
            Phrampu.RoomChannel.update_all()
          {:error, msg} -> 
            Logger.error "error in jank: #{msg}"
          _ ->
            Logger.error "something broke in jank"
        end
      ) end
      end)
  end
end
