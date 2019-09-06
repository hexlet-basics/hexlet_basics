defmodule HexletBasicsWeb.ProfileControllerTest do
  use HexletBasicsWeb.ConnCase, async: true
  alias HexletBasics.{UserManager.Guardian, User, Repo}
  import Ecto

  test "show", %{conn: conn} do
    user = insert(:user)
    conn = conn
           |> Guardian.Plug.sign_in(user)
           |> get(profile_path(conn, :show))

    assert html_response(conn, 200)
  end

  test "show without user", %{conn: conn} do
    conn = conn
           |> get(profile_path(conn, :show))

    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "delete", %{conn: conn} do
    user = insert(:will_removed_user)
    _facebook_account =
      insert(:user_account,
        uid: user.facebook_uid,
        provider: "facebook",
        user: user
      )

    _github_account =
      insert(:user_account,
        uid: to_string(user.github_uid),
        provider: "github",
        user: user
      )

    accounts = assoc(user, :accounts) |> Repo.all
    assert !Enum.empty?(accounts)

    conn = conn
           |> Guardian.Plug.sign_in(user)
           |> delete(profile_path(conn, :delete))

    removed_user = Repo.get(User, user.id)
    removed_accounts = assoc(user, :accounts) |> Repo.all

    assert redirected_to(conn) == page_path(conn, :index)
    assert User.removed?(removed_user)
    assert is_nil(removed_user.first_name)
    assert is_nil(removed_user.last_name)
    assert is_nil(removed_user.encrypted_password)
    assert is_nil(removed_user.email)
    assert is_nil(removed_user.nickname)
    assert is_nil(removed_user.reset_password_token)
    assert is_nil(removed_user.confirmation_token)
    assert Enum.empty?(removed_accounts)
  end

  test "delete without user", %{conn: conn} do
    conn = conn
           |> delete(profile_path(conn, :delete))

    %{assigns: %{current_user: current_user}} = conn

    assert current_user.guest
    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "delete_account github", %{conn: conn} do
    user = insert(:user)
    github_account =
      insert(:user_account,
        uid: to_string(user.github_uid),
        provider: "github",
        user: user
      )

    account = assoc(user, :accounts) |> Repo.get(github_account.id)

    conn = conn
           |> Guardian.Plug.sign_in(user)
           |> delete(profile_path(conn, :delete_account, account, redirect_to: profile_path(conn, :show), provider: "github"))

    removed_accounts = assoc(user, :accounts) |> Repo.all

    assert redirected_to(conn) == profile_path(conn, :show)
    assert Enum.empty?(removed_accounts)
  end

  test "delete_account without user", %{conn: conn} do
    user = insert(:user)
    github_account =
      insert(:user_account,
        uid: to_string(user.github_uid),
        provider: "github",
        user: user
      )

    account = assoc(user, :accounts) |> Repo.get(github_account.id)

    conn = conn
           |> delete(profile_path(conn, :delete_account, account, redirect_to: profile_path(conn, :show), provider: "github"))

    %{assigns: %{current_user: current_user}} = conn
    not_removed_account = assoc(user, :accounts) |> Repo.get(github_account.id)

    assert current_user.guest
    assert not_removed_account
    assert redirected_to(conn) == page_path(conn, :index)
  end
end
