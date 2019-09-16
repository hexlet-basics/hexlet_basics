defmodule HexletBasicsWeb.RemindPasswordControllerTest do
  use HexletBasicsWeb.ConnCase, async: true

  @create_attrs %{
    encrypted_password: Bcrypt.hash_pwd_salt("password"),
    email: "user@mail.ru",
    reset_password_token: "12345"
  }

  setup [:create_user]

  test "#new", %{conn: conn} do
    conn = get conn, remind_password_path(conn, :new)
    assert html_response(conn, 200)
  end

  test "#create", %{conn: conn, user: user} do
    conn = post conn, remind_password_path(conn, :create), user: %{email: user.email}
    sent_email = HexletBasics.Repo.get_by(HexletBasics.Notifications.Email, %{kind: "remind_password", recipient_id: user.id})

    assert sent_email
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
