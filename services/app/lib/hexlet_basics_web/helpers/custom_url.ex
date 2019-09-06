defmodule HexletBasicsWeb.Helpers.CustomUrl do
  use HexletBasicsWeb, :controller

  def url_by_lang(locale) do
    hosts_by_langs = %{"ru" => System.fetch_env!("APP_RU_HOST"), "en" => System.fetch_env!("APP_HOST")}
    Routes.url(%URI{scheme: System.fetch_env!("APP_SCHEME"), host: hosts_by_langs[locale]})
  end

  def redirect_current_url(conn, locale) do
    cur_path = current_path(conn)
    url_by_lang(locale) <> cur_path
  end

  def redirect_current_path(conn) do
    current_path(conn)
  end
end
