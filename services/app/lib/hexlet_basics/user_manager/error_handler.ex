defmodule HexletBasics.UserManager.ErrorHandler do
  use HexletBasicsWeb, :controller
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)
    conn
    |> HexletBasics.UserManager.Guardian.Plug.sign_out()
    |> redirect(to: "/")
  end
end
