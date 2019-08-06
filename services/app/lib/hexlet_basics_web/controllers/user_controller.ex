defmodule HexletBasicsWeb.UserController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.{User}

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    changeset = User.changeset(%User{}, params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext("User created!"))
        |> put_session(:current_user, user)
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
