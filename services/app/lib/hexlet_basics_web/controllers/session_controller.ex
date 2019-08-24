defmodule HexletBasicsWeb.SessionController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.{UserManager, UserManager.User, UserManager.Guardian}

  plug :check_authentication when action in [:create, :new]

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
    |> put_flash(:info, gettext "You have been logged out!")
    |> Guardian.Plug.sign_out()
    |> configure_session(drop: true)
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

  defp check_authentication(conn, _options) do
    %{assigns: %{current_user: current_user}} = conn

    if current_user.guest do
      conn
    else
      conn |> redirect(to: "/") |> halt()
    end
  end
end
