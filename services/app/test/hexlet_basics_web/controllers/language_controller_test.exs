defmodule HexletBasicsWeb.LanguageControllerTest do
  use HexletBasicsWeb.ConnCase

  test "index", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200)
  end

  test "show", %{conn: conn} do
    language = insert(:language)
    conn = get conn, language_path(conn, :show, language.slug)
    assert html_response(conn, 200)
  end
end
