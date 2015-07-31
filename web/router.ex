defmodule Admin.Router do
  use Admin.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Admin do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/waypoints", WaypointController do
      resources "/checkpoints", CheckpointController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Admin do
  #   pipe_through :api
  # end
end
