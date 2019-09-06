defmodule HexletBasicsWeb.AuthController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.{UserManager, UserManager.Guardian}
  alias HexletBasicsWeb.Plugs.{CheckAuthentication, ChangeLocale}
  alias Ueberauth.Strategy.Helpers

  plug Ueberauth
  plug CheckAuthentication when action in [:request, :callback]
  plug ChangeLocale when action in [:request, :callback]

  def request(conn, _params) do
    render(conn, callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, gettext("Failed to authenticate."))
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def callback(
        %{assigns: %{ueberauth_auth: %{info: %{email: nil}, provider: provider}}} =
          conn,
        _params
      ) do

    conn
    |> put_flash(
      :error,
      gettext("Please confirm the email in your %{provider} account, then try again",
        provider: provider
      )
    )
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def callback(%{assigns: %{ueberauth_auth: auth, current_user: current_user}} = conn, _params) do
    if current_user.guest do
      case UserManager.authenticate_user_by_social_network(auth) do
        {:ok, user} ->
          conn
          |> put_flash(:info, gettext("Successfully authenticated."))
          |> Guardian.Plug.sign_in(user)
          |> redirect(to: Routes.page_path(conn, :index))
        {:error, _} ->
          conn
          |> put_flash(:error, gettext("Failed to authenticate."))
          |> redirect(to: Routes.page_path(conn, :index))
      end
    else
      case UserManager.link_user_social_network_account(auth) do
        {:ok, _} ->
          conn
          |> put_flash(:info, gettext("Account successfully added."))
          |> redirect(to: Routes.profile_path(conn, :show))
        {:error, _} ->
          conn
          |> put_flash(:error, gettext("Error adding account."))
          |> redirect(to: Routes.profile_path(conn, :show))
      end
    end
  end
end
