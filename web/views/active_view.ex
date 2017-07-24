defmodule Phrampu.ActiveView do
  use Phrampu.Web, :view

  def render("who.json", %{who: who}) do
    %{
      what: who.what,
      is_tty: who.is_tty,
      student: render("student.json", %{student: who.student})
    }
  end

  def render("host.json", %{host: host}) do
    %{
      name: host.name,
      whos: render_many(host.whos, __MODULE__, "who.json", as: :who)
    }
  end

  def render("student.json", %{student: student}) do
    %{
      name: student.name
    }
  end

  def render("cluster.json", %{cluster: cluster}) do
    %{
      name: cluster.name,
      hosts: render_many(cluster.hosts, __MODULE__, "host.json", as: :host)
    }
  end

  def render("index.json", %{whos: clusters}) do
    render_many(clusters, __MODULE__, "cluster.json", as: :cluster)
  end


  def render("index.json", %{whos: whos}) do
    whos
  end
end
