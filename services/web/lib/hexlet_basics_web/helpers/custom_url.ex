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

  def hexlet_link(path \\ "/") do
    utm = %{utm_campaign: "general", utm_source: "code-basics", utm_medium: "referral"}
    utm_query = URI.encode_query(utm)
    uri = %URI{ host: "hexlet.io", query: utm_query, scheme: "https", port: 443, path: path }

    URI.to_string(uri)
  end

  def facebook_curl, do: "https://www.facebook.com/codebasicsru/"
  def youtube_curl, do: "https://www.youtube.com/user/HexletUniversity"
  def twitter_curl, do: "https://twitter.com/HexletHQ"
  def telegram_curl, do: "https://t.me/hexlet_ru"
  def slack_curl, do: "https://slack-ru.hexlet.io/"
end
