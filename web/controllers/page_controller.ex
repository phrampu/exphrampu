defmodule Phrampu.PageController do
  use Phrampu.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
