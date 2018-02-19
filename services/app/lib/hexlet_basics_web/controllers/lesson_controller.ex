defmodule HexletBasicsWeb.LessonController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.Language.Module.Lesson
  require Logger
  import Ecto.Query

  plug HexletBasicsWeb.Plugs.RequireAuth

  def next(conn, %{"lesson_id" => id}) do
    %{assigns: %{locale: locale}} = conn
    lesson = Repo.get!(Lesson, id)
    lesson = lesson |> Repo.preload([:module, :language])
    module = lesson.module
    language = lesson.language


    lessons_query = Lesson.Scope.web(Lesson, language, locale)
    next_lesson_query = from l in lessons_query,
      where: l.natural_order > ^lesson.natural_order,
      limit: 1
    case Repo.one(next_lesson_query) do
      nil ->
        conn
        |> put_flash(:info, gettext "You did it!")
        |> redirect(to: page_path(conn, :index))
      next_lesson ->
        Logger.debug inspect next_lesson
        path = language_module_lesson_path(conn, :show, language.slug, module.slug, next_lesson.slug)
        redirect conn, to: path
    end
  end
end


