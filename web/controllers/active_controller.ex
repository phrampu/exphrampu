defmodule Phrampu.ActiveController do
  use Phrampu.Web, :controller
  require Ecto.Query
  alias Phrampu.Repo
  alias Phrampu.Who

  def index(conn, _params) do
    whos = Who
      |> Who.not_idle
      |> Ecto.Query.preload([:student])
      |> Ecto.Query.preload([host: :cluster])
      |> Repo.all
    render conn, whos: whos
  end
end

