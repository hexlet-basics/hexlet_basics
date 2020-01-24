defmodule HexletBasicsWeb.PageController do
  use HexletBasicsWeb, :controller
  alias HexletBasicsWeb.Plugs.DetectDomainForRoot
  alias HexletBasicsWeb.Schemas.CompanySchema

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

    meta_attrs = [
      %{property: "og:type", content: 'website'},
      %{property: "og:title", content: gettext("Code Basics Title")},
      %{property: "og:description", content: gettext("Code Basics Description")},
      %{property: "og:image", content: Routes.static_url(conn, "/images/logo.png")},
      %{property: "og:url", content: Routes.page_url(conn, :index)},
      %{property: "description", content: gettext("Code Basics Description")},
      %{property: "image", content: Routes.static_url(conn, "/images/logo.png")}
    ]
    link_attrs = [
      %{rel: "canonical", href: Routes.page_url(conn, :index)},
      %{rel: 'image_src', href: Routes.static_url(conn, "/images/logo.png")}
    ]

    title_text = gettext("Code Basics Title")

    render(conn,
      language_by_slug: language_by_slug,
      started_languages_by_slug: started_languages_by_slug,
      meta_attrs: meta_attrs,
      link_attrs: link_attrs,
      title: title_text,
      schema: CompanySchema.build(conn)
    )
  end

  def show(conn, %{"id" => id}) do
    pages = ["about", "privacy", "tos"]

    meta_attrs = [
      %{property: "og:type", content: 'website'},
      %{property: "og:title", content: Gettext.gettext(HexletBasicsWeb.Gettext, "Code Basics Title #{id}")},
      %{property: "og:description", content: Gettext.gettext(HexletBasicsWeb.Gettext, "Code Basics Description #{id}")},
      %{property: "og:image", content: Routes.static_url(conn, "/images/logo.png")},
      %{property: "og:url", content: Routes.page_url(conn, :index)},
      %{property: "description", content: Gettext.gettext(HexletBasicsWeb.Gettext, "Code Basics Description #{id}")},
      %{property: "image", content: Routes.static_url(conn, "/images/logo.png")}
    ]
    link_attrs = [
      %{rel: "canonical", href: Routes.page_path(conn, :show, id)},
      %{rel: 'image_src', href: Routes.static_url(conn, "/images/logo.png")}
    ]

    title_text = Gettext.gettext(HexletBasicsWeb.Gettext, "Code Basics Title #{id}")

    if id in pages do
      render(conn,
      :"#{id}",
        link_attrs: link_attrs,
        meta_attrs: meta_attrs,
        title: title_text,
      )
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
end
