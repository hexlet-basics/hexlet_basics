defmodule HexletBasicsWeb.Router do
  use HexletBasicsWeb, :router

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

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HexletBasicsWeb do
    pipe_through :api

    resources "/checks", Api.CheckController, include: [:create]
  end

  scope "/", HexletBasicsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/languages", LanguageController do
      resources "/modules", Language.ModuleController do
        resources "/lessons", Language.Module.LessonController
      end
    end

    resources "/lessons", LessonController, include: [] do
      get "/redirect-to-next", LessonController, :next, as: :next
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", HexletBasicsWeb do
  #   pipe_through :api
  # end
end
