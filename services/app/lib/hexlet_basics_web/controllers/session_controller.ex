defmodule HexletBasicsWeb.SessionController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.{UserManager, UserManager.Guardian}
  alias HexletBasicsWeb.Plugs.CheckAuthentication
  alias HexletBasicsWeb.Plugs.DetectLocaleByHost

  plug DetectLocaleByHost when action in [:new]
  plug CheckAuthentication when action in [:new, :create]

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    auth = UserManager.authenticate_user(email, password)

    auth
    |> login_reply(conn)
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> clear_session
    |> put_flash(:info, gettext("You have been logged out!"))
    |> redirect(to: "/")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:info, gettext("Signed in successfully."))
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp login_reply({:error, _reason}, conn) do
    conn
    |> put_flash(:error, gettext("There was a problem with your email/password"))
    |> new(%{})
  end
end
