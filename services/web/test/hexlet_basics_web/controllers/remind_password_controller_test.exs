defmodule HexletBasicsWeb.RemindPasswordControllerTest do
  use HexletBasicsWeb.ConnCase, async: true


  @create_attrs %{
    encrypted_password: Bcrypt.hash_pwd_salt("password"),
    email: "user@mail.ru",
    reset_password_token: "reset_password_token"
  }

  setup [:create_user]

  test "#new", %{conn: conn} do
    conn = get conn, remind_password_path(conn, :new)
    assert html_response(conn, 200)
  end

  test "#create", %{conn: conn, user: user} do
    conn = post conn, remind_password_path(conn, :create), user: %{email: user.email}

    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "#update when user not found", %{conn: conn} do
    conn = post conn, remind_password_path(conn, :create), user: %{email: "notexist@mail.ru"}

    assert redirected_to(conn) == remind_password_path(conn, :new)
  end

  defp create_user(_) do
    user = insert(:user, @create_attrs)
    {:ok, user: user}
  end
end
