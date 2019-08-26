defmodule HexletBasicsWeb.LocaleController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.UserManager
  alias HexletBasicsWeb.Helpers.CustomUrl

  def switch(conn, %{"redirect_url" => redirect_url, "locale" => locale}) do
    %{assigns: %{current_user: current_user}} = conn

    if !current_user.guest && current_user != locale do
      UserManager.set_locale!(current_user, locale)
    end

    # TODO: раскоментировать после деплоя
    conn
    |> put_router_url(CustomUrl.url_by_lang(locale))
    # |> put_session(:locale, locale)
    |> redirect(external: redirect_url)
  end

  def switch(conn, _) do
    conn |> redirect(to: "/")
  end
end
