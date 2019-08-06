defmodule HexletBasicsWeb.SessionController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.{User}

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => params}) do
    user = Repo.get_by(User, email: params["email"])
    case Bcrypt.check_pass(user, params["password"]) do
    {:ok, user} ->
      conn
      |> put_session(:current_user, user)
      |> put_flash(:info, "Signed in successfully.")
      |> redirect(to: Routes.page_path(conn, :index))
    {:error, _} ->
      conn
      |> put_flash(:error, "There was a problem with your username/password")
      |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, gettext "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
