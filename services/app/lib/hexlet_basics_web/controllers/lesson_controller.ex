defmodule HexletBasicsWeb.LessonController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo, as: Repo
  alias HexletBasics.Language, as: Language

  def index(conn, _params) do
    render conn
  end

  def next(conn, %{ "id" => id}) do
    lesson = Repo.get!(Language.Module.Lesson, id)
  end
end


