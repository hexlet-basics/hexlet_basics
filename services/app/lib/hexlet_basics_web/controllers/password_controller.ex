defmodule HexletBasicsWeb.PasswordController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.{User}

  def edit(conn, %{"reset_password_token" => reset_password_token}) do
    user = Repo.get_by(User, reset_password_token: reset_password_token)
    if user do
      changeset = User.reset_password_changeset(%User{}, %{})
      render(conn, "edit.html", changeset: changeset, reset_password_token: reset_password_token)
    else
      conn
      |> put_flash(:error, gettext("User not found"))
      |> redirect(to: Routes.remind_password_path(conn, :new))
    end
  end

  def edit(conn, _) do
    conn
    |> put_flash(:error, gettext("User not found"))
    |> redirect(to: Routes.remind_password_path(conn, :new))
  end

  def update(conn, params) do
    user = Repo.get_by(User, reset_password_token: params["reset_password_token"])
    if user do
      user
      |> User.reset_password_changeset(params["user"])
      |> Repo.update()

      conn
      |> put_flash(:info, gettext("Password was change"))
      |> redirect(to: Routes.session_path(conn, :new))
    else
      conn
      |> put_flash(:error, gettext("User not found"))
      |> redirect(to: Routes.remind_password_path(conn, :new))
    end
  end
end
