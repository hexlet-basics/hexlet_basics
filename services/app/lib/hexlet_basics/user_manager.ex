defmodule HexletBasics.UserManager do
  alias Bcrypt
  alias HexletBasics.User
  import Ecto.Query, warn: false
  alias HexletBasics.Repo
  import HexletBasicsWeb.Gettext

  def get_user!(id), do: Repo.get!(User, id)

  def set_locale!(%User{} = user, locale) do
    user
    |> User.locale_changeset(%{locale: locale})
    |> Repo.update()
  end

  def authenticate_user(email, plain_text_password) do
    # NOTE: Проверка на наличия пароля нужна, потому что есть пользователи зареганые с гитхаба и у них пароля нет
    query = from u in User, where: u.email == ^email and not(is_nil(u.encrypted_password))
    case Repo.one(query) do
      nil ->
        Bcrypt.no_user_verify()
        {:error, gettext("There was a problem with your email/password")}
      user ->
        cond do
          !User.active?(user) ->
            {:error, gettext("You have not yet verified your email")}
          Bcrypt.verify_pass(plain_text_password, user.encrypted_password) ->
            {:ok, user}
          true ->
            {:error, gettext("There was a problem with your email/password")}
        end
    end
  end
end
