defmodule HexletBasics.UserManager.ErrorHandler do
  use HexletBasicsWeb, :controller
  import Plug.Conn
  import HexletBasicsWeb.Gettext
  alias HexletBasicsWeb.Router.Helpers, as: Routes

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type = :unauthenticated, _reason}, _opts) do
    conn
    |> put_flash(:error, gettext("Sorry, you have to sign in."))
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> HexletBasics.UserManager.Guardian.Plug.sign_out()
    |> redirect(to: "/")
  end
end
