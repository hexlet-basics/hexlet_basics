defmodule HexletBasics.UserManagerTest do
  use HexletBasics.DataCase

  alias HexletBasics.{UserManager, User}

  @github_auth %{
    info: %{email: "user@user.ru", nickname: "user"},
    uid: 123_456,
    provider: :github
  }

  @facebook_auth %{
    info: %{email: "user@user.ru", nickname: "user"},
    uid: "123456",
    provider: :facebook
  }

  test "authenticate_user_by_social_network/1 by github create new user and account" do
    {:ok, user} = UserManager.authenticate_user_by_social_network(@github_auth)

    account =
      UserManager.get_account(%{
        provider: to_string(@github_auth[:provider]),
        uid: to_string(@github_auth[:uid])
      })

    assert user.email == @github_auth[:info][:email]
    assert account.user_id == user.id
  end

  test "authenticate_user_by_social_network/1 by facebook create new user and account" do
    {:ok, user} = UserManager.authenticate_user_by_social_network(@facebook_auth)

    account =
      UserManager.get_account(%{
        provider: to_string(@facebook_auth[:provider]),
        uid: @facebook_auth[:uid]
      })

    assert user.email == @facebook_auth[:info][:email]
    assert account.user_id == user.id
  end

  test "authenticate_user_by_social_network/1 by github with existing active user" do
    user = insert(:user, email: "user@user.ru")
    user_auth = Map.replace!(@github_auth, :info, %{email: user.email, nickname: user.nickname})

    {:ok, auth_user} = UserManager.authenticate_user_by_social_network(user_auth)

    account =
      UserManager.get_account(%{
        provider: to_string(@github_auth[:provider]),
        uid: to_string(@github_auth[:uid])
      })

    assert user == auth_user
    assert account.user_id == user.id
  end

  test "authenticate_user_by_social_network/1 by facebook with existing active user" do
    user = insert(:user, email: "user@user.ru")
    user_auth = Map.replace!(@facebook_auth, :info, %{email: user.email, nickname: user.nickname})

    {:ok, auth_user} = UserManager.authenticate_user_by_social_network(user_auth)

    account =
      UserManager.get_account(%{
        provider: to_string(@facebook_auth[:provider]),
        uid: @facebook_auth[:uid]
      })

    assert user == auth_user
    assert account.user_id == user.id
  end

  test "authenticate_user_by_social_network/1 by github with existing user not active user" do
    user = insert(:user, email: "user@user.ru", state: "waiting_confirmation")
    user_auth = Map.replace!(@github_auth, :info, %{email: user.email, nickname: user.nickname})

    {:ok, auth_user} = UserManager.authenticate_user_by_social_network(user_auth)

    account =
      UserManager.get_account(%{
        provider: to_string(@github_auth[:provider]),
        uid: to_string(@github_auth[:uid])
      })

    assert user.id == auth_user.id
    assert User.active?(auth_user)
    assert account.user_id == user.id
  end

  test "authenticate_user_by_social_network/1 by facebook with existing user not active user" do
    user = insert(:user, email: "user@user.ru", state: "initial")
    user_auth = Map.replace!(@facebook_auth, :info, %{email: user.email, nickname: user.nickname})

    {:ok, auth_user} = UserManager.authenticate_user_by_social_network(user_auth)

    account =
      UserManager.get_account(%{
        provider: to_string(@facebook_auth[:provider]),
        uid: @facebook_auth[:uid]
      })

    assert user.id == auth_user.id
    assert User.active?(auth_user)
    assert account.user_id == user.id
  end

  test "authenticate_user_by_social_network/1 by github with existing user and existing account" do
    user = insert(:user, email: "user@user.ru")

    account =
      insert(:user_account,
        uid: to_string(@github_auth[:uid]),
        provider: to_string(@github_auth[:provider]),
        user: user
      )

    user_auth = Map.replace!(@github_auth, :info, %{email: user.email, nickname: user.nickname})

    {:ok, auth_user} = UserManager.authenticate_user_by_social_network(user_auth)

    new_account =
      UserManager.get_account(%{
        provider: to_string(user_auth[:provider]),
        uid: to_string(user_auth[:uid])
      })

    assert user.id == auth_user.id
    assert User.active?(auth_user)
    assert account.id == new_account.id
  end

  test "authenticate_user_by_social_network/1 by facebook with existing user and existing account" do
    user = insert(:user, email: "user@user.ru")

    account =
      insert(:user_account,
        uid: @facebook_auth[:uid],
        provider: to_string(@facebook_auth[:provider]),
        user: user
      )

    user_auth = Map.replace!(@facebook_auth, :info, %{email: user.email, nickname: user.nickname})

    {:ok, auth_user} = UserManager.authenticate_user_by_social_network(user_auth)

    new_account =
      UserManager.get_account(%{
        provider: to_string(user_auth[:provider]),
        uid: to_string(user_auth[:uid])
      })

    assert user.id == auth_user.id
    assert User.active?(auth_user)
    assert account.id == new_account.id
  end

  test "authenticate_user_by_social_network/1 by github with existing user and existing account but not active user" do
    user = insert(:user, email: "user@user.ru", state: "initial")

    account =
      insert(:user_account,
        uid: to_string(@github_auth[:uid]),
        provider: to_string(@github_auth[:provider]),
        user: user
      )

    user_auth = Map.replace!(@github_auth, :info, %{email: user.email, nickname: user.nickname})

    {:ok, auth_user} = UserManager.authenticate_user_by_social_network(user_auth)

    new_account =
      UserManager.get_account(%{
        provider: to_string(user_auth[:provider]),
        uid: to_string(user_auth[:uid])
      })

    assert user.id == auth_user.id
    assert User.active?(auth_user)
    assert account.id == new_account.id
  end

  test "authenticate_user_by_social_network/1 by facebook with existing user and existing account but not active user" do
    user = insert(:user, email: "user@user.ru", state: "waiting_confirmation")

    account =
      insert(:user_account,
        uid: @facebook_auth[:uid],
        provider: to_string(@facebook_auth[:provider]),
        user: user
      )

    user_auth = Map.replace!(@facebook_auth, :info, %{email: user.email, nickname: user.nickname})

    {:ok, auth_user} = UserManager.authenticate_user_by_social_network(user_auth)

    new_account =
      UserManager.get_account(%{
        provider: to_string(user_auth[:provider]),
        uid: to_string(user_auth[:uid])
      })

    assert user.id == auth_user.id
    assert User.active?(auth_user)
    assert account.id == new_account.id
  end

  test "disable_delivery!/1" do
    user = insert(:user)
    disabled_delivery_user = UserManager.disable_delivery!(user)

    assert User.disabled_delivery?(disabled_delivery_user)
  end

  test "enable_delivery!/1" do
    user = insert(:user, email_delivery_state: "disabled")
    enabled_delivery_user = UserManager.enable_delivery!(user)
   
    assert User.enabled_delivery?(enabled_delivery_user)
  end
end
