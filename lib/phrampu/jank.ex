defmodule Jank do
  alias Phrampu.Host
  alias Phrampu.Repo

  def jank() do
    Host
      |> Repo.all 
      |> Enum.map(fn(c) -> c.name end) 
      |> Enum.map(fn(h) -> spawn_link fn -> (
        case Phrampu.WhoModule.get_who(h) do 
          {:ok, ret} -> 
            ret |> Phrampu.WhoModule.insert_whos(h)
            Phrampu.RoomChannel.update_all()
          err -> IO.inspect err
        end
      ) end
      end)
  end
end
