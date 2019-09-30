defmodule HexletBasicsWeb.Plugs.ChangeLocale do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _) do
    %{assigns: %{locale: default_locale, current_user: current_user}} = conn

    locale_from_session = get_session(conn, :locale)

    locale = current_user.locale || locale_from_session || default_locale

    Gettext.put_locale(HexletBasicsWeb.Gettext, locale)
    conn
    |> assign(:locale, locale)
  end
end
