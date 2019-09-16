defmodule HexletBasics.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.{User, Notifications.Email}

  @derive {Jason.Encoder, only: [:first_name, :last_name, :nickname, :guest]}

  schema "users" do
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:github_uid, :integer)
    field(:facebook_uid, :string)
    field(:nickname, :string)
    field(:state, :string, default: "initial")
    field(:email_delivery_state, :string, default: "enabled")
    field(:encrypted_password, :string)
    field(:confirmation_token, :string)
    field(:reset_password_token, :string)
    field(:password, :string, virtual: true)
    field(:locale, :string)
    field(:guest, :boolean, virtual: true, default: false)
    has_many(:finished_lessons, User.FinishedLesson, on_delete: :delete_all)

    has_many(:finished_lesson_lessons, through: [:finished_lessons, :language_module_lesson])
    has_many(:finished_lesson_modules, through: [:finished_lesson_lessons, :module])
    has_many(:finished_lesson_languages, through: [:finished_lesson_modules, :language])

    has_many(:emails, Email, foreign_key: :recipient_id)

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:nickname, :email, :state])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end

  def state_changeset(%User{} = user, attrs \\ %{}) do
    user |> cast(attrs, [:state])
  end

  def email_delivery_state_changeset(%User{} = user, attrs \\ %{}) do
    user |> cast(attrs, [:email_delivery_state])
  end

  def locale_changeset(%User{} = user, attrs \\ %{}) do
    user |> cast(attrs, [:locale])
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:nickname, :email, :password, :first_name, :last_name, :state, :locale])
    |> validate_required([:email, :password])
    |> validate_length(:password, min: 6)
    |> put_hash_password
    |> put_initial_state
    |> generate_token(:confirmation_token)
    |> unique_constraint(:email)
  end

  def reset_password_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6)
    |> put_hash_password
  end

  def directory_for_code(current_user) do
    current_user.id
    |> Integer.to_string()
    |> String.pad_leading(6, "0")
    |> String.reverse()
    |> String.to_charlist()
    |> Enum.chunk_every(3)
    |> Path.join()
  end

  def generate_token(changeset, attr) do
    length = 64
    crypto = :crypto.strong_rand_bytes(length)

    token =
      crypto
      |> Base.url_encode64()
      |> binary_part(0, length)

    changeset |> change(%{attr => token})
  end

  def active?(user) do
    user.state == "active"
  end

  def disabled_delivery?(user) do
    user.email_delivery_state == "disabled"
  end

  def enabled_delivery?(user) do
    user.email_delivery_state == "enabled"
  end

  defp put_initial_state(changeset) do
    changeset |> put_change(:state, "initial")
  end

  defp put_hash_password(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, encrypted_password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_hash_password(changeset), do: changeset
end
