defmodule Phrampu.ActiveView do
  use Phrampu.Web, :view

  def render("who.json", %{who: who}) do
    %{
      what: who.what,
      host: render("host.json", %{host: who.host})
    }
  end

  def render("host.json", %{host: host}) do
    %{
      id: host.id,
      name: host.name
    }
  end

  def render("cluster.json", %{cluster: cluster}) do
    %{
      name: cluster.name
    }
  end

  def render("index.json", %{whos: clusters}) do
    render_many(clusters, __MODULE__, "cluster.json", as: :cluster)
  end


  def render("index.json", %{whos: whos}) do
    whos
  end
end
