defmodule Jank do
  alias Phrampu.Host
  alias Phrampu.Repo
  require Logger

  def jank() do
    :ssh.start
    Host
      |> Repo.all 
      |> Enum.map(fn(c) -> c.name end) 
      |> Enum.map(fn(h) -> spawn_link fn -> (
        case Phrampu.WhoModule.get_who(h) do 
          {:ok, ret} -> 
            ret |> Phrampu.WhoModule.insert_whos(h)
            Phrampu.RoomChannel.update_all()
            Logger.info "Successfully added whos"
          {:error, msg} -> 
            Logger.error "error in jank: #{msg}"
        end
      ) end
      end)
  end
end
