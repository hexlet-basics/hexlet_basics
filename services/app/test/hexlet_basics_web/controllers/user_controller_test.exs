defmodule HexletBasicsWeb.UserControllerTest do
  use HexletBasicsWeb.ConnCase, async: true


  @create_attrs %{password: "password", email: "user@mail.ru"}
  @invalid_attrs %{password: nil, email: nil}

  test "render new", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200)
  end

  test "create user", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @create_attrs

    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200)
  end
end
