defmodule HexletBasicsWeb.LanguageController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.{Language, Language.Module, Language.Module.Lesson}
  import Ecto.Query

  def show(conn, %{"id" => id}) do
    %{assigns: %{current_user: current_user}} = conn
    user_finished_lessons_by_lesson = current_user
                      |> Ecto.assoc(:finished_lessons)
                      |> Repo.all
                      |> ExtEnum.key_by(:language_module_lesson_id)

    language = Repo.get_by!(Language, slug: id)

    modules_assoc = Ecto.assoc(language, :modules)
    modules = modules_assoc
              |> Module.Scope.web(language)
              |> Repo.all
              |> Repo.preload(lessons: Lesson.Scope.web(Lesson, language))

    module_descriptions_assoc = Ecto.assoc(language, :module_descriptions)
    module_description_query = from d in module_descriptions_assoc,
      where: d.locale == ^conn.assigns[:locale]
    descriptions_by_module = module_description_query
                             |> Repo.all
                             |> ExtEnum.key_by(:module_id)

    lesson_descriptions_assoc = Ecto.assoc(language, :lesson_descriptions)
    lesson_description_query = from d in lesson_descriptions_assoc,
      where: d.locale == ^conn.assigns[:locale]
    descriptions_by_lesson = lesson_description_query
                             |> Repo.all
                             |> ExtEnum.key_by(:lesson_id)

    lessons_assoc = Ecto.assoc(language, :lessons)
    lessons_query = lessons_assoc
                    |> Lesson.Scope.web(language)

    first_lesson = lessons_query
                   |> limit(1)
                   |> Repo.one
                   |> Repo.preload(:module)

    next_lesson = case current_user.guest do
      true -> first_lesson
      false ->
        next_lesson_query = from l in lessons_query,
          left_join: fl in assoc(l, :user_finished_lessons),
          on: fl.user_id == ^current_user.id,
          where: is_nil(fl.id),
          limit: 1
        Repo.one(next_lesson_query)
    end
    next_lesson = next_lesson |> Repo.preload(:module)

    render conn, language: language,
      descriptions_by_module: descriptions_by_module,
      modules: modules,
      next_lesson: next_lesson,
      first_lesson: first_lesson,
      user_finished_lessons_by_lesson: user_finished_lessons_by_lesson,
      descriptions_by_lesson: descriptions_by_lesson
  end
end
