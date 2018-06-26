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

  def show(conn, %{"id" => id}) do
    pages = ["about"]
    if id in pages do
      render conn, :"#{id}"
    else
      message = "Cannot find page '#{id}'"
      raise Phoenix.Router.NoRouteError, conn: conn, router: conn.private.phoenix_router, message: message
    end
  end
end
