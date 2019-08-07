require IEx
defmodule HexletBasicsWeb.SessionControllerTest do
  use HexletBasicsWeb.ConnCase, async: true

  @create_attrs %{ encrypted_password: Bcrypt.hash_pwd_salt("password"), email: "user@mail.ru" }
  @session_attrs %{ password: "password", email: "user@mail.ru" }

  test "#new", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200)
  end

  test "#create", %{conn: conn} do
    user = insert(:user, @create_attrs)
    conn = post conn, session_path(conn, :create), session: @session_attrs

    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "#delete", %{conn: conn} do
    user = insert(:user, @create_attrs)
    conn = conn
           |> put_session(:current_user, user)
           |> delete(session_path(conn, :delete))

    assert redirected_to(conn) == page_path(conn, :index)
  end
end
