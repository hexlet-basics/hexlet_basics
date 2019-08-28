defmodule HexletBasicsWeb.Plugs.SetLocale do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _) do
    langs = Application.fetch_env!(:hexlet_basics, :langs)
    locale = Map.get(langs, conn.host, "en")

    Gettext.put_locale(HexletBasicsWeb.Gettext, locale)
    conn
    |> assign(:locale, locale)
  end
end
