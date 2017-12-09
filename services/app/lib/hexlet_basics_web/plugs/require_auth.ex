defmodule HexletBasicsWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller
  import HexletBasicsWeb.Gettext
  alias HexletBasicsWeb.Router.Helpers, as: RouteHelpers

  def init(options), do: options

  def call(conn, _) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:danger, gettext "Require auth")
      |> redirect(to: RouteHelpers.page_path(conn, :index))
      |> halt
    end
  end

end
