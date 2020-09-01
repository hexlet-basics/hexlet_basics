defmodule HexletBasicsWeb.Router do
  use HexletBasicsWeb, :router
  use Plug.ErrorHandler

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  defp handle_errors(_conn, %{reason: %Phoenix.Router.NoRouteError{}}), do: :ok

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
    plug(:fetch_session)
    plug(PhoenixGon.Pipeline)
    plug(HexletBasics.UserManager.Pipeline)
    plug(HexletBasicsWeb.Plugs.AssignCurrentUser)
    plug(HexletBasicsWeb.Plugs.SetLocale)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(HexletBasicsWeb.Plugs.AssignGlobals)
    plug(HexletBasicsWeb.Plugs.SetUrl)
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(HexletBasics.UserManager.Pipeline)
    plug(HexletBasicsWeb.Plugs.AssignCurrentUser)
    plug(HexletBasicsWeb.Plugs.SetLocale)
    plug(HexletBasicsWeb.Plugs.ApiRequireAuth)
  end

  pipeline :api_for_webhooks do
    plug(:accepts, ["json"])
    plug(:fetch_session)
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

  scope "/api/webhooks", HexletBasicsWeb do
    pipe_through(:api_for_webhooks)

    post("/sparkpost/process", Api.Webhooks.SparkpostController, :process)
  end

  scope "/", HexletBasicsWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/pages", PageController)
    get("/robots.txt", PageController, :robots)

    resources("/session", SessionController, singleton: true)
    resources "/registrations", UserController, only: [:create, :new]
    post("/user/:user_id/resend_confirmation", UserController, :resend_confirmation)
    get("/confirm", UserController, :confirm)

    get("/switch", LocaleController, :switch)

    resources("/remind-password", RemindPasswordController, only: [:new, :create])
    resources("/password", PasswordController, only: [:edit, :update], singleton: true)

    resources "/languages", LanguageController do
      resources "/modules", Language.ModuleController do
        resources("/lessons", Language.Module.LessonController)
      end
    end

    resources "/lessons", LessonController, include: [] do
      get("/redirect-to-next", LessonController, :next, as: :member)
    end
  end

  scope "/", HexletBasicsWeb do
    pipe_through [:browser, :ensure_auth]

    resources "/profile", ProfileController, only: [:show, :delete], singleton: true
    delete("/profile/delete_account/:account_id", ProfileController, :delete_account)

    post("/reset_password", PasswordController, :reset_password)
  end

  # Other scopes may use custom stacks.
  # scope "/api", HexletBasicsWeb do
  #   pipe_through :api
  # end
end
