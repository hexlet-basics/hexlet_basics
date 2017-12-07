defmodule HexletBasicsWeb.LessonController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo, as: Repo
  alias HexletBasics.Language, as: Language
  require Logger
  import Ecto.Query

  def next(conn, %{ "lesson_id" => id}) do
    lesson = Repo.get!(Language.Module.Lesson, id)
      |> Repo.preload([:module, :language])
    module = lesson.module
    language = lesson.language

    partial_path = &(language_module_lesson_path(conn, :show, language.slug, &1, &2))

    next_lesson_query = from l in Language.Module.Lesson,
      where: l.module_id == ^lesson.module_id and l.order > ^lesson.order,
      order_by: [asc: l.order],
      limit: 1
    redirect_path = case Repo.one(next_lesson_query) do
      nil -> nil
      next_lesson ->
        Logger.debug inspect next_lesson
        partial_path.(module.slug, next_lesson.slug)
    end

    redirect_path = case redirect_path do
      nil ->
        next_module_query = from m in Language.Module,
        where: m.language_id == ^language.id and m.order > ^module.order,
        order_by: [asc: m.order],
        limit: 1
        next_module = Repo.one(next_module_query)
        if next_module do
          first_lesson_in_next_module_query = from l in Language.Module.Lesson,
          where: l.module_id == ^next_module.id,
          order_by: [asc: l.order],
          limit: 1
          next_module_lesson = Repo.one(first_lesson_in_next_module_query)
          if next_module_lesson do
            partial_path.(next_module.slug, next_module_lesson.slug)
          end
        end
      path -> path
    end

    case redirect_path do
      nil ->
        conn
        |> put_flash(:info, "You did it!")
        |> redirect(to: page_path(conn, :index))
      path -> redirect conn, to: path
    end

    # next lesson in current module
    # first lesson in next module
    # lessons finished
  end
end


