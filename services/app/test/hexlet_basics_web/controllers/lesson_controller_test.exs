defmodule HexletBasicsWeb.LessonControllerTest do
  use HexletBasicsWeb.ConnCase

  test "next", %{conn: conn} do
    lesson = insert(:language_module_lesson)
    conn = get conn, lesson_member_path(conn, :next, lesson.id)
    assert html_response(conn, 302)
  end
end
