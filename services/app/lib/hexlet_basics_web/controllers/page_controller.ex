defmodule HexletBasicsWeb.PageController do
  use HexletBasicsWeb, :controller

  def index(conn, _params) do
    languages = HexletBasics.Repo.all(HexletBasics.Language)
    # IO.inspect languages
    languagesBySlug = Enum.reduce(languages, %{}, fn(l, acc) ->
      langName = String.to_atom(l.slug)
      Map.put(acc, langName, l)
    end)
    # IO.inspect languagesBySlug
    render conn, languagesBySlug
  end
end
