defmodule HexletBasicsWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller
  # alias SimpleBlog.Router.Helpers, as: RouteHelpers

  def init(options), do: options

  def call(conn, _) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:danger, "Require auth")
      |> redirect(to: "/") # TODO use routing
      |> halt
    end
  end

end
