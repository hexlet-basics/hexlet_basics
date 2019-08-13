defmodule HexletBasics.UserManager do
  alias Bcrypt
  alias HexletBasics.User
  import Ecto.Query, warn: false
  alias HexletBasics.Repo

  def get_user!(id), do: Repo.get!(User, id)

  def authenticate_user(email, plain_text_password) do
    query = from u in User, where: u.email == ^email
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
end
