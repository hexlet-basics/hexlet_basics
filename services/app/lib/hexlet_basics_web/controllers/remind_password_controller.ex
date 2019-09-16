defmodule HexletBasicsWeb.RemindPasswordController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.{User, Repo}
  alias HexletBasics.Notifications

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    user = Repo.get_by(User, email: params["email"])
    if user do
      {:ok, user} = user
                     |> User.generate_token(:reset_password_token)
                     |> Repo.update()

        email = Ecto.build_assoc(user, :emails, %{kind: "remind_password"})
                |> Repo.insert!()

        email
        |> Notifications.send_email(conn, user)

      conn
      |> put_flash(:info, gettext("Message with instructions for reset password was sent"))
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:error, gettext("User not found"))
      |> redirect(to: Routes.remind_password_path(conn, :new))
    end
  end
end
