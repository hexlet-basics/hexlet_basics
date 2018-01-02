defmodule HexletBasicsWeb.Plugs.SetLocale do
  import Plug.Conn
  # import Phoenix.Controller
  # import HexletBasicsWeb.Gettext
  # alias HexletBasicsWeb.Router.Helpers, as: RouteHelpers

  def init(options), do: options

  def call(conn, _) do
    params = Application.fetch_env!(:hexlet_basics, :common)
    locale = Map.get(params.langs, conn.host, "ru")
    Gettext.put_locale(HexletBasicsWeb.Gettext, locale)
    conn
    |> assign(:locale, locale)
  end

end
