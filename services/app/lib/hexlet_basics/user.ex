defmodule HexletBasics.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.User

  @derive {Jason.Encoder, only: [:first_name, :last_name, :nickname, :guest]}

  schema "users" do
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:github_uid, :integer)
    field(:facebook_uid, :string)
    field(:nickname, :string)
    field(:encrypted_password, :string)
    field(:password, :string, virtual: true)
    field(:guest, :boolean, virtual: true, default: false)
    has_many(:finished_lessons, User.FinishedLesson, on_delete: :delete_all)

    has_many(:finished_lesson_lessons, through: [:finished_lessons, :language_module_lesson])
    has_many(:finished_lesson_modules, through: [:finished_lesson_lessons, :module])
    has_many(:finished_lesson_languages, through: [:finished_lesson_modules, :language])

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:nickname, :email, :password])
    |> validate_required([:email, :password])
    # |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> hash_password
    # |> unique_constraint(:email)
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

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:encrypted_password, Bcrypt.hash_pwd_salt(password))
    else
      changeset
    end
  end
end
