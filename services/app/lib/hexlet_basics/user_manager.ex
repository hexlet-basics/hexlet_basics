defmodule HexletBasics.UserManager do
  alias Bcrypt
  alias HexletBasics.{User, User.Account}
  alias HexletBasics.StateMachines.{UserStateMachine, User.EmailDeliveryStateMachine}
  import Ecto.Query, warn: false
  alias HexletBasics.Repo

  def get_user!(id), do: Repo.get!(User, id)
  def get_user(id), do: Repo.get(User, id)
  def user_get_by(params), do: Repo.get_by(User, params)

  def set_locale!(%User{} = user, locale) do
    user
    |> User.locale_changeset(%{locale: locale})
    |> Repo.update()
  end

  def authenticate_user(email, plain_text_password) do
    # NOTE: Проверка на наличия пароля нужна, потому что есть пользователи зареганые с гитхаба и у них пароля нет
    query = from(u in User, where: u.email == ^email and not is_nil(u.encrypted_password))

    case Repo.one(query) do
      nil ->
        Bcrypt.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Bcrypt.verify_pass(plain_text_password, user.encrypted_password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def get_account(params), do: Repo.get_by(Account, params)

  def authenticate_user_by_social_network(%{
        info: %{email: email, nickname: nickname},
        uid: uid,
        provider: provider
      }) do
    uid = if is_binary(uid), do: uid, else: to_string(uid)
    provider = Atom.to_string(provider)

    account =
      get_account(%{provider: provider, uid: uid})
      |> Repo.preload(:user)

    if account do
      user = activate_user!(account.user)
      {:ok, user}
    else
      user = user_get_by(email: email) || %User{}

      Repo.transaction(fn ->
        user =
          if new_record?(user) do
            {:ok, %User{state: state}} = Machinery.transition_to(user, UserStateMachine, "active")

            user
            |> User.changeset(%{nickname: nickname, email: email, state: state})
            |> Repo.insert!()
          else
            activate_user!(user)
          end

        create_account(%{provider: provider, uid: uid, user_id: user.id})
        user
      end)
    end
  end

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  def disable_delivery!(user) do
    {:ok, %User{email_delivery_state: state}} =
      Machinery.transition_to(user, EmailDeliveryStateMachine, "disabled")

    user
    |> User.email_delivery_state_changeset(%{email_delivery_state: state})
    |> Repo.update!()
  end

  def enable_delivery!(user) do
    {:ok, %User{email_delivery_state: state}} =
      Machinery.transition_to(user, EmailDeliveryStateMachine, "enabled")

    user
    |> User.email_delivery_state_changeset(%{email_delivery_state: state})
    |> Repo.update!()
  end

  defp activate_user!(user) do
    {:ok, %User{state: state}} =
      Machinery.transition_to(user, UserStateMachine, "active")

    user
    |> User.state_changeset(%{state: state})
    |> Repo.update!()
  end

  defp new_record?(user) do
    case Ecto.get_meta(user, :state) do
      :loaded -> false
      :built -> true
    end
  end
end
