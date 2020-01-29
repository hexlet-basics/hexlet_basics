defmodule HexletBasicsWeb.UserControllerTest do
  use HexletBasicsWeb.ConnCase, async: true
  alias HexletBasics.{UserManager.Guardian, UserManager}

  @create_attrs %{password: "password", email: "user@mail.ru", confirmation_token: "1234"}
  @waiting_confirmation_attrs %{password: "password", email: "user@mail.ru", confirmation_token: "1234", state: "waiting_confirmation"}
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

  test "confirm user", %{conn: conn} do
    user = insert(:user, @waiting_confirmation_attrs)

    conn = get conn, user_path(conn, :confirm, confirmation_token: user.confirmation_token)

    confirmed_user = UserManager.get_user!(user.id)
    assert redirected_to(conn) == page_path(conn, :index)
    assert confirmed_user.state == "active"
  end

  test "confirm user when user not found", %{conn: conn} do
    user = insert(:user, @waiting_confirmation_attrs)

    conn = get conn, user_path(conn, :confirm, confirmation_token: "abcd")

    confirmed_user = UserManager.get_user!(user.id)
    assert redirected_to(conn) == page_path(conn, :index)
    assert confirmed_user.state == "waiting_confirmation"
  end

  test "resend_confirmation", %{conn: conn} do
    user = insert(:user, @waiting_confirmation_attrs)
    conn =
      conn
      |> Guardian.Plug.sign_in(user)
      |> post(user_path(conn, :resend_confirmation, user, redirect_to: profile_path(conn, :show)))

    not_confirmed_user = UserManager.get_user!(user.id)
    assert not_confirmed_user.confirmation_token != user.confirmation_token
    assert redirected_to(conn) == profile_path(conn, :show)
  end
end
