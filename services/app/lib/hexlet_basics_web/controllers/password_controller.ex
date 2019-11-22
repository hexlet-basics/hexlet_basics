defmodule HexletBasicsWeb.PasswordController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.{User, Email, Notifier, UserManager}

  def edit(conn, %{"reset_password_token" => reset_password_token}) do
    user = UserManager.user_get_by(reset_password_token: reset_password_token)

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
    user = UserManager.user_get_by(reset_password_token: params["reset_password_token"])

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

  def reset_password(%{assigns: %{current_user: current_user}} = conn, params) do
    redirect_to = params["redirect_to"] || Routes.page_path(conn, :index)

    user =
      current_user
      |> User.generate_token(:reset_password_token)
      |> Repo.update!()

    email =
      Email.reset_password_html_email(
        conn,
        user,
        Routes.password_url(conn, :edit, reset_password_token: user.reset_password_token)
      )

    email
    |> Notifier.send_email(user)

    conn
    |> put_flash(:info, gettext("Message with instructions for reset password was sent"))
    |> redirect(to: redirect_to)
  end
end
