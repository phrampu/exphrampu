defmodule Phrampu.WhoListController do
  use Phrampu.Web, :controller
  require Ecto.Query
  alias Phrampu.Repo
  alias Phrampu.Who
  alias Phrampu.Cluster
  alias Phrampu.Host

  def index(conn, _params) do
    whos = Who 
      |> Who.get_active_whos() 
      |> Ecto.Query.preload([:host])
      |> Ecto.Query.preload([:student])
      |> Repo.all
    render conn, whos: whos
  end
end

