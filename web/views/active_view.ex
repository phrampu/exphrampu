defmodule Phrampu.ActiveView do
  use Phrampu.Web, :view

  def render("index.json", %{whos: whos}) do
    whos
  end
end
