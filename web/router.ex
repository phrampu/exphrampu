defmodule Phrampu.Router do
  use Phrampu.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Phrampu do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/students", StudentController
    resources "/clusters", ClusterController
    resources "/hosts", HostController
    resources "/whos", WhoController
  end

  scope "/api", Phrampu do
    pipe_through :api

    resources "/active", ActiveController
  end
end
