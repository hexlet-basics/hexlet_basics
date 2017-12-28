defmodule HexletBasicsWeb.LanguageController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.Language
  alias HexletBasics.Language.Module.Lesson
  import Ecto.Query

  def show(conn, %{"id" => id}) do
    %{assigns: %{current_user: current_user}} = conn
    # TODO: where is polymorphism?
    current_user = if current_user.guest, do: current_user, else: Repo.preload(current_user, :finished_lessons)
    user_finished_lessons_by_lesson = if current_user.guest do
      %{}
    else
      current_user.finished_lessons
      |> Enum.reduce(%{}, &(Map.put(&2, &1.language_module_lesson_id, &1)))
    end

    language = Repo.get_by!(HexletBasics.Language, slug: id)
    query = from m in Language.Module,
      where: m.language_id == ^language.id and m.upload_id == ^language.upload_id,
      order_by: [asc: m.order]
    modules = Repo.all(query)
    modules = modules |> Repo.preload(lessons: from(Language.Module.Lesson, order_by: [asc: :order]))

    module_description_query = from d in Language.Module.Description,
      where: d.locale == ^conn.assigns[:locale] and d.language_id == ^language.id

    module_descriptions = Repo.all(module_description_query)
    descriptions_by_module = module_descriptions
                             |> Enum.reduce(%{}, &(Map.put(&2, &1.module_id, &1)))

    lesson_description_query = from d in Lesson.Description,
      where: d.locale == ^conn.assigns[:locale] and d.language_id == ^language.id

    lesson_descriptions = Repo.all(lesson_description_query)
    descriptions_by_lesson = lesson_descriptions
                             |> Enum.reduce(%{}, &(Map.put(&2, &1.lesson_id, &1)))

    lessons_query = Ecto.assoc(language, :lessons)
    lessons_query = from l in lessons_query,
      order_by: [asc: l.natural_order],
      limit: 1
    first_lesson = Repo.one(lessons_query)
    first_lesson = first_lesson |> Repo.preload(:module)


    next_lesson = case current_user.guest do
      true -> first_lesson
      false ->
        next_lesson_query = from l in Language.Module.Lesson,
          left_join: fl in assoc(l, :user_finished_lessons),
          on: fl.user_id == ^current_user.id,
          where: l.language_id == ^language.id and is_nil(fl.id),
          order_by: [asc: l.natural_order],
          limit: 1
        Repo.one(next_lesson_query)
    end
    next_lesson = next_lesson |> Repo.preload(:module)

    render conn, language: language,
      modules: modules,
      descriptions_by_module: descriptions_by_module,
      next_lesson: next_lesson,
      first_lesson: first_lesson,
      user_finished_lessons_by_lesson: user_finished_lessons_by_lesson,
      descriptions_by_lesson: descriptions_by_lesson
  end
end

