defmodule HexletBasicsWeb.Helpers.CustomUrl do
  use HexletBasicsWeb, :controller

  def url_by_lang(locale) do
    #TODO: переделать после деплоя
    # hosts_by_langs = %{"ru" => System.get_env("APP_RU_HOST"), "en" => System.get_env("APP_HOST")}

    # hosts_by_langs = %{"ru" => "ru.code-basics.test", "en" => "en.code-basics.test"}
    hosts_by_langs = %{"ru" => "code-basics.ru", "en" => "code-basics.com"}
    Routes.url(%URI{scheme: System.get_env("APP_SCHEME"), host: hosts_by_langs[locale]})
  end

  def redirect_current_url(conn, locale) do
    cur_path = current_path(conn)
    url_by_lang(locale) <> cur_path
  end
end
