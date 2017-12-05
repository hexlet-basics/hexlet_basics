defmodule HexletBasicsWeb.Language.Module.LessonControllerTest do
  use HexletBasicsWeb.ConnCase

  test "show", %{conn: conn} do
    lesson = insert(:language_module_lesson)
    module = lesson.module
    language = lesson.language
    conn = get conn, language_module_lesson_path(conn, :show, language.slug, module.slug, lesson.id)
    assert html_response(conn, 200)
  end
end

