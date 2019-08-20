defmodule HexletBasicsWeb.Plugs.SubdomainRedirects do
  import Plug.Conn
  alias HexletBasicsWeb.Helpers.CustomUrl
  use HexletBasicsWeb, :controller

  def init(options), do: options

  def call(conn, _) do
    %{assigns: %{locale: locale}} = conn

    cond do
      conn.host == System.get_env("APP_RU_HOST") ->
        conn
        |> put_router_url(CustomUrl.url_by_lang(locale))
      locale == "ru" ->
        conn
        |> put_router_url(CustomUrl.url_by_lang(locale))
        |> redirect(external: CustomUrl.redirect_current_url(conn, locale))
        |> halt()
      true ->
        conn
    end
  end
end
