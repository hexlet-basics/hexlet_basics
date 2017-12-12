defmodule HexletBasicsWeb.Plugs.SetLocale do
  import Plug.Conn
  # import Phoenix.Controller
  # import HexletBasicsWeb.Gettext
  # alias HexletBasicsWeb.Router.Helpers, as: RouteHelpers

  def init(options), do: options

  def call(conn, _) do
    locale = "ru"
    Gettext.put_locale(HexletBasicsWeb.Gettext, locale)
    conn
    |> assign(:locale, locale)
  end

end
