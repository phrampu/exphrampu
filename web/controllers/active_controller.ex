defmodule Phrampu.ActiveController do
  use Phrampu.Web, :controller
  require Ecto.Query
  alias Phrampu.Repo
  alias Phrampu.Who
  alias Phrampu.Cluster
  alias Phrampu.Host

  def index(conn, _params) do
    #whos = Who
      #|> Who.not_idle
      #|> Who.is_recent
      #|> Ecto.Query.preload([:student])
      #|> Ecto.Query.preload([host: :cluster])
      #|> Repo.all

    # this is gonna be so slow
    # nvm this is sexy as hell
    whos = Cluster 
      |> Cluster.get_active_whos() 
      |> Repo.all
    render conn, whos: whos
  end

  #def index(conn, _params) do
    #whos = Who
      #|> Who.not_idle
      #|> Who.is_recent
      #|> Ecto.Query.preload([:student])
      #|> Ecto.Query.preload([host: :cluster])
      #|> Repo.all
    #render conn, whos: whos
  #end
end

