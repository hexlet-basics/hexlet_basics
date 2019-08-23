defmodule HexletBasicsWeb.Language.Module.LessonController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasicsWeb.Serializers
  alias HexletBasics.User
  alias HexletBasics.Language
  alias HexletBasics.Language.Module.Lesson
  import PhoenixGon.Controller
  import Ecto.Query

  def index(conn, %{"module_id" => module_id, "language_id" => language_id}) do
    %{assigns: %{current_user: current_user, locale: locale}} = conn

    language = Repo.get_by(Language, slug: language_id)
    module = Repo.get_by(Language.Module, language_id: language.id, slug: module_id)

    module_description_assoc = Ecto.assoc(module, :descriptions)
    module_description_query =
      from(d in module_description_assoc,
        where: d.locale ==^locale
      )
    module_description = Repo.one(module_description_query)

    user_finished_lessons_by_lesson =
      current_user
      |> Ecto.assoc(:finished_lessons)
      |> Repo.all()
      |> ExtEnum.key_by(:language_module_lesson_id)

    lesson_descriptions_assoc = Ecto.assoc(language, :lesson_descriptions)
    lesson_description_query =
      from(d in lesson_descriptions_assoc,
        where: d.locale == ^locale
      )
    descriptions_by_lesson =
      lesson_description_query
      |> Repo.all()
      |> ExtEnum.key_by(:lesson_id)

    query = from l in Language.Module.Lesson,
      where: l.language_id == ^language.id and l.upload_id == ^language.upload_id and l.module_id == ^module.id,
      order_by: [asc: l.order]
    lessons = Repo.all(query)

    render(
      conn,
      language: language,
      module: module,
      lessons: lessons,
      user_finished_lessons_by_lesson: user_finished_lessons_by_lesson,
      descriptions_by_lesson: descriptions_by_lesson,
      module_description: module_description
    )
  end

  def show(conn, %{"id" => id, "module_id" => module_id, "language_id" => language_id}) do
    %{assigns: %{locale: locale, current_user: current_user}} = conn

    language = Repo.get_by!(Language, slug: language_id)
    module = Repo.get_by!(Language.Module, language_id: language.id, slug: module_id)

    module_description =
      Repo.get_by!(Language.Module.Description, module_id: module.id, locale: locale)

    lesson =
      Repo.get_by!(Language.Module.Lesson,
        language_id: language.id,
        module_id: module.id,
        slug: id
      )

    lesson_description =
      Repo.get_by!(Language.Module.Lesson.Description, lesson_id: lesson.id, locale: locale)

    user_finished_lesson =
      if current_user.guest do
        nil
      else
        Repo.get_by(User.FinishedLesson,
          user_id: current_user.id,
          language_module_lesson_id: lesson.id
        )
      end

    lessons_query = Ecto.assoc(language, :lessons)

    lessons_query =
      from(l in lessons_query,
        where: l.upload_id == ^language.upload_id
      )

    lessons_count = Repo.aggregate(lessons_query, :count, :id)

    prev_lesson_query = Lesson.Scope.web_without_sorting(Lesson, language, locale)

    prev_lesson_query =
      from(l in prev_lesson_query,
        where: l.natural_order < ^lesson.natural_order,
        order_by: [desc: l.natural_order],
        limit: 1
      )

    prev_lesson_data =
      case Repo.one(prev_lesson_query) do
        nil ->
          nil

        prev_lesson ->
          prev_lesson
          |> Repo.preload([:module])
          |> Serializers.PrevLessonSerializer.to_map()
      end

    conn =
      put_gon(conn,
        lesson: lesson,
        lesson_description: lesson_description,
        prev_lesson: prev_lesson_data,
        language: language,
        user_finished_lesson: user_finished_lesson
      )

    lesson_theory_html = Earmark.as_html!(lesson_description.theory)
    lesson_instructions_html = Earmark.as_html!(lesson_description.instructions)

    render(conn,
      language: language,
      module: module,
      lesson: lesson,
      lesson_theory_html: lesson_theory_html,
      lesson_inserted_at: lesson.inserted_at,
      lesson_updated_at: lesson.updated_at,
      lesson_instructions_html: lesson_instructions_html,
      module_description: module_description,
      lesson_description: lesson_description,
      lessons_count: lessons_count,
      layout: {HexletBasicsWeb.LayoutView, "lesson.html"}
    )
  end
end
