defmodule Phrampu.WhoListView do
  use Phrampu.Web, :view

  def render("who.json", %{who: who}) do
    %{
      what: who.what,
      student: render("student.json", %{student: who.student}),
      host: render("host.json", %{host: who.host})
    }
  end

  def render("student.json", %{student: student}) do
    %{
      name: student.name
    }
  end

  def render("host.json", %{host: host}) do
    %{
      name: host.name
    }
  end

  def render("index.json", %{whos: whos}) do
    render_many(whos, __MODULE__, "who.json", as: :who)
  end

end
