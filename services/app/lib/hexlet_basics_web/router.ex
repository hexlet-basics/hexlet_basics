defmodule HexletBasicsWeb.Router do
  use HexletBasicsWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stacktrace}) do
    conn =
      conn
      |> Plug.Conn.fetch_cookies()
      |> Plug.Conn.fetch_query_params()

    params =
      case conn.params do
        %Plug.Conn.Unfetched{aspect: :params} -> "unfetched"
        other -> other
      end

    occurrence_data = %{
      "request" => %{
        "cookies" => conn.req_cookies,
        "url" => "#{conn.scheme}://#{conn.host}:#{conn.port}#{conn.request_path}",
        "user_ip" => List.to_string(:inet.ntoa(conn.remote_ip)),
        "headers" => Enum.into(conn.req_headers, %{}),
        "method" => conn.method,
        "params" => params
      },
      "server" => %{
        "pid" => System.get_env("MY_SERVER_PID"),
        "host" => "#{System.get_env("MY_HOSTNAME")}:#{System.get_env("MY_PORT")}",
        "root" => System.get_env("MY_APPLICATION_PATH")
      }
    }

    Rollbax.report(kind, reason, stacktrace, _custom_data = %{}, occurrence_data)
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(HexletBasicsWeb.Plugs.SetLocale)
    plug(:fetch_session)
    plug(HexletBasicsWeb.Plugs.AssignCurrentUser)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(HexletBasicsWeb.Plugs.AssignGlobals)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(HexletBasicsWeb.Plugs.SetLocale)
    plug(:fetch_session)
    plug(HexletBasicsWeb.Plugs.AssignCurrentUser)
    plug(HexletBasicsWeb.Plugs.ApiRequireAuth)
  end

  scope "/auth", HexletBasicsWeb do
    pipe_through(:browser)

    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
  end

  scope "/api", HexletBasicsWeb do
    pipe_through(:api)

    resources "/lessons", Api.LessonController, include: [] do
      resources("/checks", Api.Lesson.CheckController, include: [:create])
    end
  end

  scope "/", HexletBasicsWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/pages", PageController)

    resources("/session", SessionController, singleton: true)
    get "/logout", SessionController, :logout

    resources "/languages", LanguageController do
      resources "/modules", Language.ModuleController do
        resources("/lessons", Language.Module.LessonController)
      end
    end

    resources "/lessons", LessonController, include: [] do
      get("/redirect-to-next", LessonController, :next, as: :member)
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", HexletBasicsWeb do
  #   pipe_through :api
  # end
end
