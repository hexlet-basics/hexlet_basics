defmodule HexletBasicsWeb.PageController do
  use HexletBasicsWeb, :controller

  def index(conn, _params) do
    languages = HexletBasics.Repo.all(HexletBasics.Language)
    language_by_slug = Enum.reduce(languages, %{}, fn(l, acc) ->
      lang_name = String.to_atom(l.slug)
      Map.put(acc, lang_name, l)
    end)
    render conn, language_by_slug
  end
end
