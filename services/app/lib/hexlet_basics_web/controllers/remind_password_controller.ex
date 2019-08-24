defmodule HexletBasicsWeb.RemindPasswordController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.{User}
  alias HexletBasics.Email
  alias HexletBasics.Mailer

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

      email = Email.reset_password_html_email(conn,
                                              user.email,
                                              Routes.password_path(conn, :edit, reset_password_token: user.reset_password_token))

      email
      |> Mailer.deliver_later

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
