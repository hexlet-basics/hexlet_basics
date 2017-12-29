defmodule HexletBasicsWeb.LanguageControllerTest do
  use HexletBasicsWeb.ConnCase

  test "index", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200)
  end

  test "show", %{conn: conn} do
    lesson = insert(:language_module_lesson)
    language = lesson.language
    conn = get conn, language_path(conn, :show, language.slug)
    assert html_response(conn, 200)
  end

  test "show for signed user", %{conn: conn} do
    user = insert(:user)
    lesson = insert(:language_module_lesson)
    language = lesson.language
    conn = conn
           |> put_session(:current_user, user)
           |> get(language_path(conn, :show, language.slug))
    assert html_response(conn, 200)
  end
end
