defmodule HexletBasicsWeb.PageControllerTest do
  use HexletBasicsWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200)
  end

  test "show about", %{conn: conn} do
    conn = get conn, page_path(conn, :show, "about")
    assert html_response(conn, 200)
  end

  test "must be 404", %{conn: conn} do
    assert_raise Phoenix.Router.NoRouteError, fn ->
      get conn, page_path(conn, :show, "bla-bla-bla")
    end
  end
end
