defmodule HexletBasicsWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :hexlet_basics

  socket "/socket", HexletBasicsWeb.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :hexlet_basics, gzip: false,
    only: ~w(locales assets fonts images robots.txt favicon.ico
      apple-touch-icon-57x57.png apple-touch-icon-60x60.png apple-touch-icon-72x72.png
      apple-touch-icon-76x76.png apple-touch-icon-114x114.png apple-touch-icon-120x120.png
      apple-touch-icon-144x144.png apple-touch-icon-152x152.png favicon-16x16.png favicon-32x32.png
      favicon-96x96.png favicon-128.png favicon-196x196.png mstile-70x70.png mstile-144x144.png
      mstile-150x150.png mstile-310x150.png mstile-310x310.png)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_hexlet_basics_key",
    signing_salt: "mKGV92uB"

  plug PhoenixGon.Pipeline
  plug HexletBasicsWeb.Router

  @doc """
  Callback invoked for dynamically configuring the endpoint.

  It receives the endpoint configuration and checks if
  configuration should be loaded from the system environment.
  """
  def init(_key, config) do
    if config[:load_from_system_env] do
      port = System.get_env("PORT") || raise "expected the PORT environment variable to be set"
      {:ok, Keyword.put(config, :http, [:inet6, port: port])}
    else
      {:ok, config}
    end
  end
end
