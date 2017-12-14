defmodule HexletBasicsWeb.LanguageController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.Language
  alias HexletBasics.Language.Module.Lesson
  import Ecto.Query

  def show(conn, %{"id" => id}) do
    language = Repo.get_by(HexletBasics.Language, slug: id)
    query = from m in Language.Module,
      where: m.language_id == ^language.id and m.upload_id == ^language.upload_id,
      order_by: [asc: m.order]
    modules = Repo.all(query)
              |> Repo.preload(lessons: from(Language.Module.Lesson, order_by: [asc: :order]))

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

    render conn, language: language,
      modules: modules,
      descriptions_by_module: descriptions_by_module,
      descriptions_by_lesson: descriptions_by_lesson
  end
end

