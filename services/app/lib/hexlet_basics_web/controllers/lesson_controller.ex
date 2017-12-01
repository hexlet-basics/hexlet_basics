defmodule HexletBasicsWeb.LessonController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo, as: Repo
  alias HexletBasics.Language, as: Language

  def index(conn, _params) do
    render conn
  end

  def show(conn, %{ "id" => id, "module_id" => module_id, "language_id" => language_id }) do
    language = Repo.get_by(Language, slug: language_id)
    module = Repo.get_by(Language.Module, language_id: language.id, slug: module_id)
    lesson = Repo.get_by(Language.Module.Lesson,  language_id: language.id, module_id: module.id, slug: id)
    render conn, language: language, module: module, lesson: lesson
  end
end

