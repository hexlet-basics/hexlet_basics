defmodule HexletBasicsWeb.UserController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.Mailer
  alias HexletBasics.Email
  alias HexletBasics.{User}

  plug :check_authentication when action in [:create, :new]

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    changeset = User.registration_changeset(%User{}, params)
    case Repo.insert(changeset) do
      {:ok, user} ->

        # TODO: пока отключил посылку писем с потдверждением
        # Email.confirmation_html_email(conn,
        #                               user.email,
        #                               Routes.user_path(conn, :new, confirmation_token: user.confirmation_token))
        # |> Mailer.deliver_now

        conn
        |> put_session(:current_user, user)
        |> put_flash(:info, gettext("User created!"))
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

  defp check_authentication(conn, options) do
    %{assigns: %{current_user: current_user}} = conn

    if current_user.guest do
      conn
    else
      conn |> redirect(to: "/") |> halt()
    end
  end
end
