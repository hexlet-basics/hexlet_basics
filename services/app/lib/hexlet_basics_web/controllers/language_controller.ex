defmodule HexletBasicsWeb.LanguageController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.{Language, Language.Module, Language.Module.Lesson}
  import Ecto.Query

  def show(conn, %{"id" => id}) do
    %{assigns: %{current_user: current_user, locale: locale}} = conn

    user_finished_lessons_by_lesson =
      current_user
      |> Ecto.assoc(:finished_lessons)
      |> Repo.all()
      |> ExtEnum.key_by(:language_module_lesson_id)

    language = Repo.get_by!(Language, slug: id)

    modules_assoc = Ecto.assoc(language, :modules)

    modules =
      modules_assoc
      |> Module.Scope.web(language, locale)
      |> Repo.all()
      |> Repo.preload(lessons: Lesson.Scope.web(Lesson, language, locale))

    module_descriptions_assoc = Ecto.assoc(language, :module_descriptions)

    module_description_query =
      from(d in module_descriptions_assoc,
        where: d.locale == ^conn.assigns[:locale]
      )

    descriptions_by_module =
      module_description_query
      |> Repo.all()
      |> ExtEnum.key_by(:module_id)

    lesson_descriptions_assoc = Ecto.assoc(language, :lesson_descriptions)

    lesson_description_query =
      from(d in lesson_descriptions_assoc,
        where: d.locale == ^conn.assigns[:locale]
      )

    descriptions_by_lesson =
      lesson_description_query
      |> Repo.all()
      |> ExtEnum.key_by(:lesson_id)

    lessons_assoc = Ecto.assoc(language, :lessons)

    lessons_query =
      lessons_assoc
      |> Lesson.Scope.web(language, locale)

    first_lesson =
      lessons_query
      |> limit(1)
      |> Repo.one()
      |> Repo.preload(:module)

    next_lesson =
      case current_user.guest do
        true ->
          first_lesson

        false ->
          next_lesson_query =
            from(l in lessons_query,
              left_join: fl in assoc(l, :user_finished_lessons),
              on: fl.user_id == ^current_user.id,
              where: is_nil(fl.id),
              limit: 1
            )

          Repo.one(next_lesson_query)
      end

    next_lesson = next_lesson |> Repo.preload(:module)

    titleText = Gettext.gettext(HexletBasicsWeb.Gettext, "OG title #{language.slug}")
    header = Gettext.gettext(HexletBasicsWeb.Gettext, "Header #{language.slug}")

    meta_attrs = [%{property: "og:type", content: 'article'},
      %{property: "og:title", content: titleText},
      %{property: "og:description", content: Gettext.gettext(HexletBasicsWeb.Gettext, "OG description #{language.slug}")},
      %{property: "og:image", content: url(conn, Routes.static_path(conn, "/images/#{language.slug}.png"))},
      %{property: "og:url", content: url(conn, Routes.language_path(conn, :show, language.slug))},
      %{property: "name", content: Gettext.gettext(HexletBasicsWeb.Gettext, "OG title #{language.slug}")},
      %{property: "description", content: Gettext.gettext(HexletBasicsWeb.Gettext, "OG description #{language.slug}")},
      %{property: "image", content: url(conn, Routes.static_path(conn, "/images/#{language.slug}.png"))}
    ]
    link_attrs = [%{rel: "canonical", href: url(conn, Routes.language_path(conn, :show, language.slug))},
      %{rel: 'image_src', href: url(conn, Routes.static_path(conn, "/images/#{language.slug}.png"))}
    ]

    render(conn,
      language: language,
      descriptions_by_module: descriptions_by_module,
      modules: modules,
      next_lesson: next_lesson,
      first_lesson: first_lesson,
      user_finished_lessons_by_lesson: user_finished_lessons_by_lesson,
      descriptions_by_lesson: descriptions_by_lesson,
      meta_attrs: meta_attrs,
      link_attrs: link_attrs,
      title: titleText,
      header: header
    )
  end

  def url(conn, path) do
    "#{conn.scheme}://#{conn.host}#{path}"
  end
end
