defmodule HexletBasicsWeb.Plugs.ApiRequireAuth do
  import Plug.Conn
  # import Phoenix.Controller
  # import HexletBasicsWeb.Gettext
  # alias HexletBasicsWeb.Router.Helpers, as: RouteHelpers

  def init(options), do: options

  def call(conn, _) do
    if conn.assigns.current_user.guest do
      conn
      |> send_resp(403, "Forbidden")
      |> halt()
    else
      conn
    end
  end
end
