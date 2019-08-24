defmodule HexletBasicsWeb.LessonController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.Language.Module.Lesson
  require Logger
  import Ecto.Query

  plug(HexletBasicsWeb.Plugs.RequireAuth)

  def next(conn, %{"lesson_id" => id}) do
    %{assigns: %{locale: locale, current_user: current_user}} = conn
    lesson = Repo.get!(Lesson, id)
    lesson = lesson |> Repo.preload([:language])
    language = lesson.language

    lessons_query = Lesson.Scope.web(Lesson, language, locale)

    next_lesson_query =
      from(l in lessons_query,
        where: l.natural_order > ^lesson.natural_order,
        limit: 1
      )

    next_not_finished_lesson_query =
      from(l in lessons_query,
        left_join: fl in assoc(l, :user_finished_lessons),
        on: fl.user_id == ^current_user.id,
        where: is_nil(fl.id),
        limit: 1
      )

    case Repo.one(next_lesson_query) || Repo.one(next_not_finished_lesson_query) do
      nil ->
        conn
        |> put_flash(:info, gettext("You did it!"))
        |> redirect(to: Routes.page_path(conn, :index))

      next_lesson ->
        next_lesson = next_lesson |> Repo.preload([:module])
        Logger.debug(inspect(next_lesson))
        module = next_lesson.module

        path =
          Routes.language_module_lesson_path(conn, :show, language.slug, module.slug, next_lesson.slug)

        redirect(conn, to: path)
    end
  end
end
