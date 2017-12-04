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

    lesson = Repo.get_by!(Language.Module.Lesson,  language_id: language.id, module_id: module.id, slug: id)
    lesson_description = Repo.get_by!(Language.Module.Lesson.Description,  lesson_id: lesson.id, locale: "ru")

    query_lessons = from l in Language.Module.Lesson, where: l.upload_id == ^language.upload_id
    lessons_count = Repo.aggregate(query_lessons, :count, :id)
    query_next_lessons = from l in Language.Module.Lesson, where: l.upload_id == ^language.upload_id and l.order > ^lesson.order
    next_lessons_count = Repo.aggregate(query_next_lessons, :count, :id)

    lesson_order_natural = lessons_count - next_lessons_count

    conn = put_gon(conn, lesson: lesson, lesson_description: lesson_description, language: language)

    render conn,
      language: language,
      module: module,
      lesson: lesson,
      module_description: module_description,
      lesson_description: lesson_description,
      lessons_count: lessons_count,
      lesson_order_natural: lesson_order_natural
  end
end

