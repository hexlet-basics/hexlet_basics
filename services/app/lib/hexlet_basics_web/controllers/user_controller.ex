defmodule HexletBasicsWeb.UserController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.{User, Email, Mailer, Repo, UserManager.Guardian}
  alias HexletBasics.StateMachines.UserStateMachine

  plug :check_authentication when action in [:create, :new]

  def new(conn, _params) do
    changeset = User.registration_changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    %{assigns: %{locale: locale}} = conn
    changeset = User.registration_changeset(%User{}, Map.put(params, "locale", locale))
    case Repo.insert(changeset) do {:ok, user} ->

        email = Email.confirmation_html_email(
          conn,
          user,
          Routes.user_url(conn, :confirm, confirmation_token: user.confirmation_token)
        )

        email
        |> Mailer.deliver_now

        {:ok, %User{state: state}} =  Machinery.transition_to(user, UserStateMachine, "waiting_confirmation")

        user
        |> User.state_changeset(%{state: state})
        |> Repo.update()

        conn
        |> put_flash(:info, gettext("User created! Check your email for confirm registration"))
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

  def confirm(conn, params) do
    user = Repo.get_by(User, confirmation_token: params["confirmation_token"])
    if user do

      if User.active?(user) do
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: "/")
      else
        {:ok, %User{state: state}} =  Machinery.transition_to(user, UserStateMachine, "active")

        user = user
               |> User.state_changeset(%{state: state})
               |> Repo.update!()

        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, gettext("Registration confirmed! Welcome!"))
        |> redirect(to: "/")
      end
    else
      conn
      |> put_flash(:error, gettext("User not found"))
      |> redirect(to: "/")
    end
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
