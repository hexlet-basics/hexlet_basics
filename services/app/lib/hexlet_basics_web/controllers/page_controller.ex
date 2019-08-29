defmodule HexletBasicsWeb.PageController do
  use HexletBasicsWeb, :controller
  alias HexletBasicsWeb.Plugs.DetectDomainForRoot

  plug DetectDomainForRoot when action in [:index]

  def index(conn, _params) do
    %{assigns: %{current_user: current_user}} = conn

    started_languages =
      HexletBasics.Repo.all(Ecto.assoc(current_user, :finished_lesson_languages))

    started_languages_by_slug =
      started_languages
      |> Enum.map(& &1.slug)

    languages = HexletBasics.Repo.all(HexletBasics.Language)

    language_by_slug =
      Enum.reduce(languages, %{}, fn l, acc ->
        lang_name = String.to_atom(l.slug)
        Map.put(acc, lang_name, l)
      end)

    render(conn,
      language_by_slug: language_by_slug,
      started_languages_by_slug: started_languages_by_slug
    )
  end

  def show(conn, %{"id" => id}) do
    pages = ["about", "privacy", "tos"]

    link_attrs = [%{rel: "canonical", href: url(conn, Routes.page_path(conn, :show, id))}]
    if id in pages do
      render(conn, :"#{id}", link_attrs: link_attrs)
    else
      message = "Cannot find page '#{id}'"

      raise Phoenix.Router.NoRouteError,
        conn: conn,
        router: conn.private.phoenix_router,
        message: message
    end
  end

  def robots(conn, _) do
    render(conn, "robots.txt")
  end

 def url(conn, path) do
    "#{conn.scheme}://#{conn.host}#{path}"
  end
end
