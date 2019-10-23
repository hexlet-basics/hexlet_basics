defmodule HexletBasicsWeb.UserController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.{User, Repo, UserManager.Guardian, StateMachines.UserStateMachine}
  alias HexletBasics.{Email, Notifier}
  alias HexletBasicsWeb.Plugs.CheckAuthentication
  alias HexletBasicsWeb.Plugs.DetectLocaleByHost

  plug CheckAuthentication when action in [:new, :create]
  plug DetectLocaleByHost when action in [:new]

  def new(conn, _params) do
    changeset = User.registration_changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    %{assigns: %{locale: locale}} = conn
    changeset = User.registration_changeset(%User{}, Map.put(params, "locale", locale))

    case Repo.insert(changeset) do
      {:ok, user} ->
        email =
          Email.confirmation_html_email(
            conn,
            user,
            Routes.user_url(conn, :confirm, confirmation_token: user.confirmation_token)
          )

        email
        |> Notifier.send_email(user)

        {:ok, %User{state: state}} =
          Machinery.transition_to(user, UserStateMachine, "waiting_confirmation")

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
        {:ok, %User{state: state}} = Machinery.transition_to(user, UserStateMachine, "active")

        user
        |> User.state_changeset(%{state: state})
        |> Repo.update()

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
end
