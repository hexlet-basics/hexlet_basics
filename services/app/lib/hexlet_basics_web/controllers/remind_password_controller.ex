defmodule HexletBasicsWeb.RemindPasswordController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.{User}

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    user = Repo.get_by(User, email: params["email"])
    if user do
      conn |> redirect(to: "/")
    else
      conn
      |> put_flash(:error, gettext("User not found"))
      |> redirect(to: Routes.remind_password_path(conn, :new))
    end
  end
end
