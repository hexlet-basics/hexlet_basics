defmodule HexletBasicsWeb.Language.Module.LessonController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo, as: Repo
  alias HexletBasics.Language, as: Language
  import PhoenixGon.Controller
  import Ecto.Query

  plug :put_layout, "lesson.html"

  def index(conn, _params) do
    render conn
  end

  def show(conn, %{ "id" => id, "module_id" => module_id, "language_id" => language_id }) do
    language = Repo.get_by!(Language, slug: language_id)
    module = Repo.get_by!(Language.Module, language_id: language.id, slug: module_id)
    module_description = Repo.get_by!(Language.Module.Description,  module_id: module.id, locale: "ru")

    query = from l in Language.Module.Lesson,
      where: l.language_id == ^language.id and l.upload_id == ^language.upload_id and l.module_id == ^module.id,
      order_by: [asc: l.order]
    lessons = Repo.all(query)
    module_length = length(lessons)

    
    # test = testLesson.order

    lesson = Repo.get_by!(Language.Module.Lesson,  language_id: language.id, module_id: module.id, slug: id)
    lesson_description = Repo.get_by!(Language.Module.Lesson.Description,  lesson_id: lesson.id, locale: "ru")
    lesson_order_natural = Enum.find_index(lessons, fn(x) -> x.order == lesson.order end) + 1

    conn = put_gon(conn, lesson: lesson, lesson_description: lesson_description, language: language)

    render conn,
      language: language,
      module: module,
      lesson: lesson,
      module_description: module_description,
      lesson_description: lesson_description,
      module_length: module_length,
      lesson_order_natural: lesson_order_natural
  end
end

