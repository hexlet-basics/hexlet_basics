defmodule HexletBasicsWeb.Plugs.DetectDomainForRoot do
  import Plug.Conn
  alias HexletBasicsWeb.Helpers.CustomUrl
  use HexletBasicsWeb, :controller

  def init(options), do: options

  def call(conn, _) do
    %{assigns: %{locale: default_locale, current_user: current_user}} = conn

    locale_from_session = get_session(conn, :locale)

    locale = current_user.locale || locale_from_session || default_locale
    cond do
      conn.host == System.fetch_env!("APP_RU_HOST") ->
        conn
        |> put_session(:locale, "ru")
      locale == "ru" ->
        conn
        |> redirect(external: CustomUrl.redirect_current_url(conn, locale))
        |> halt()
      true ->
        conn
    end
  end
end
