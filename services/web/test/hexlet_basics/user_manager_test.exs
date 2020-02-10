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

  test "link_user_social_network_account/1 github" do
    user = insert(:user, email: "user@user.ru")
    user_auth = Map.replace!(@github_auth, :info, %{email: user.email, nickname: user.nickname})
     {:ok, user} = UserManager.link_user_social_network_account(user_auth, user)

    account =
      UserManager.get_account(%{
        provider: to_string(@github_auth[:provider]),
        uid: to_string(@github_auth[:uid])
      })

    assert user.email == @github_auth[:info][:email]
    assert account.user_id == user.id
  end

  test "link_user_social_network_account/1 facebook" do
    user = insert(:user, email: "user@user.ru")
    user_auth = Map.replace!(@facebook_auth, :info, %{email: user.email, nickname: user.nickname})
     {:ok, user} = UserManager.link_user_social_network_account(user_auth, user)

    account =
      UserManager.get_account(%{
        provider: to_string(@facebook_auth[:provider]),
        uid: @facebook_auth[:uid]
      })

    assert user.email == @facebook_auth[:info][:email]
    assert account.user_id == user.id
  end

  test "user_get_by with removed user" do
    removed_user = insert(:user, state: "removed", email: "removed_user@mail.com")

    result_for_removed = UserManager.user_get_by(%{email: removed_user.email})
    assert is_nil(result_for_removed)
  end

  test "user_get_by" do
    user = insert(:user, email: "user@user.com")
    result_for_active = UserManager.user_get_by(%{email: user.email})
    assert result_for_active
  end
end
