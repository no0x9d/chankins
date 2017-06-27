defmodule Chankins.Web.Router do
  use Chankins.Web, :router

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

  scope "/", Chankins.Web do
    pipe_through :browser # Use the default browser stack

    get "/", ProjectController, :index
    resources "/projects", ProjectController
    resources "/releases", ReleaseController
    resources "/versions", VersionController
    resources "/features", FeatureController
    resources "/parameters", ParameterController

  end

  # Other scopes may use custom stacks.
   scope "/api", Chankins.Web, as: :api do
     pipe_through :api
     resources "/projects", API.ProjectController
    resources "/releases", API.ReleaseController
   end
end
