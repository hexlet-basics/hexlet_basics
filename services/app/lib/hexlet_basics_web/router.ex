defmodule HexletBasicsWeb.Router do
  use HexletBasicsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug HexletBasicsWeb.Plugs.SetLocale
    plug :fetch_session
    plug HexletBasicsWeb.Plugs.AssignCurrentUser
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug HexletBasicsWeb.Plugs.SetLocale
    plug :fetch_session
    plug HexletBasicsWeb.Plugs.AssignCurrentUser
    plug HexletBasicsWeb.Plugs.RequireAuth
  end

  scope "/auth", HexletBasicsWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  scope "/api", HexletBasicsWeb do
    pipe_through :api

    resources "/lessons", Api.LessonController, include: [] do
      resources "/checks", Api.Lesson.CheckController, include: [:create]
    end
  end

  scope "/", HexletBasicsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/session", SessionController, singleton: true
    resources "/languages", LanguageController do
      resources "/modules", Language.ModuleController do
        resources "/lessons", Language.Module.LessonController
      end
    end

    resources "/lessons", LessonController, include: [] do
      get "/redirect-to-next", LessonController, :next, as: :member
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", HexletBasicsWeb do
  #   pipe_through :api
  # end
end
