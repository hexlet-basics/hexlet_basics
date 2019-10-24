defmodule HexletBasicsWeb.PasswordControllerTest do
  use HexletBasicsWeb.ConnCase, async: true
  alias HexletBasics.{UserManager.Guardian, UserManager}

  @reset_password_token "123456"
  @create_attrs %{
    encrypted_password: Bcrypt.hash_pwd_salt("password"),
    email: "user@mail.ru",
    reset_password_token: @reset_password_token
  }
  @update_attrs %{encrypted_password: Bcrypt.hash_pwd_salt("new_password")}

  setup [:create_user]

  test "#edit", %{conn: conn} do
    conn = get conn, password_path(conn, :edit, reset_password_token: @reset_password_token)
    assert html_response(conn, 200)
  end

  test "#edit without params", %{conn: conn} do
    conn = get conn, password_path(conn, :edit)
    assert redirected_to(conn) == remind_password_path(conn, :new)
  end

  test "#edit when user not found", %{conn: conn} do
    conn = get conn, password_path(conn, :edit, reset_password_token: "123")
    assert redirected_to(conn) == remind_password_path(conn, :new)
  end


  test "#update", %{conn: conn} do
    conn = patch conn, password_path(conn, :update, reset_password_token: @reset_password_token), user: @update_attrs

    assert redirected_to(conn) == session_path(conn, :new)
  end

  test "#update when user not found", %{conn: conn} do
    conn = patch conn, password_path(conn, :update, reset_password_token: "123"), user: @update_attrs

    assert redirected_to(conn) == remind_password_path(conn, :new)
  end

  test "reset_password", %{conn: conn, user: user} do
    conn =
      conn
      |> Guardian.Plug.sign_in(user)
      |> post(password_path(conn, :reset_password, redirect_to: profile_path(conn, :show)))

    reset_password_user = UserManager.get_user!(user.id)
    assert redirected_to(conn) == profile_path(conn, :show)
    assert user.reset_password_token != reset_password_user.reset_password_token
  end

  defp create_user(_) do
    user = insert(:user, @create_attrs)
    {:ok, user: user}
  end
end
