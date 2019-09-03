defmodule HexletBasicsWeb.AuthController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.{UserManager, UserManager.Guardian}
  alias HexletBasicsWeb.Plugs.CheckAuthentication
  alias Ueberauth.Strategy.Helpers

  plug Ueberauth
  plug CheckAuthentication when action in [:request, :callback]

  def request(conn, _params) do
    render(conn, callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, gettext("Failed to authenticate."))
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def callback(
        %{assigns: %{ueberauth_auth: %{info: %{email: nil}, uid: uid, provider: provider}}} =
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

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user = UserManager.authenticate_user_by_social_network(auth)

    conn
    |> put_flash(:info, gettext("Successfully authenticated."))
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
