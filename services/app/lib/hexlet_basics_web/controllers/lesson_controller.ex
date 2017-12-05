defmodule HexletBasicsWeb.LessonController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo, as: Repo
  alias HexletBasics.Language, as: Language

  def next(conn, %{ "id" => id}) do
    lesson = Repo.get!(Language.Module.Lesson, id)
    # next lesson in current module
    # first lesson in next module
    # lessons finished
  end
end


