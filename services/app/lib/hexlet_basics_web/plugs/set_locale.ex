defmodule HexletBasicsWeb.Plugs.SetLocale do
  import Plug.Conn

  @available_locales ["en", "ru"]

  def init(options), do: options

  def call(conn, _) do
    %{assigns: %{current_user: current_user}} = conn

    lang_from_header = extract_accept_language(conn)
                       |> Enum.find(nil, &supported_locale?(&1))

    langs = Application.fetch_env!(:hexlet_basics, :langs)
    locale_from_host = Map.get(langs, conn.host, "en")
    locale_from_session = get_session(conn, :locale)
    subdomain = if supported_locale?(conn.private[:subdomain]), do: conn.private[:subdomain], else: nil

    locale = subdomain || current_user.locale || locale_from_session || lang_from_header || locale_from_host

    Gettext.put_locale(HexletBasicsWeb.Gettext, locale)
    conn
    |> put_session(:locale, locale)
    |> assign(:locale, locale)
  end

  defp supported_locale?(locale), do: Enum.member?(@available_locales, locale)

  defp extract_accept_language(conn) do
    case Plug.Conn.get_req_header(conn, "accept-language") do
      [value | _] ->
        value
        |> String.split(",")
        |> Enum.map(&parse_language_option/1)
        |> Enum.sort(&(&1.quality > &2.quality))
        |> Enum.map(&(&1.tag))
        |> Enum.reject(&is_nil/1)
        |> ensure_language_fallbacks()

      _ ->
        []
    end
  end

  defp parse_language_option(string) do
    captures = Regex.named_captures(~r/^\s?(?<tag>[\w\-]+)(?:;q=(?<quality>[\d\.]+))?$/i, string)

    quality = case Float.parse(captures["quality"] || "1.0") do
      {val, _} -> val
      _ -> 1.0
    end

    %{tag: captures["tag"], quality: quality}
  end

  defp ensure_language_fallbacks(tags) do
    Enum.flat_map tags, fn tag ->
      [language | _] = String.split(tag, "-")
      if Enum.member?(tags, language), do: [tag], else: [tag, language]
    end
  end
end
