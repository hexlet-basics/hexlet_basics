defmodule HexletBasics.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.User


  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :github_uid, :integer
    field :nickname, :string
    field :guest, :boolean, virtual: true, default: false

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:github_uid, :nickname, :email])
    |> validate_required([:github_uid, :nickname, :email])
  end

  def directory_for_code(current_user) do
    current_user.id
    |> Integer.to_string
    |> String.pad_leading(6, "0")
    |> String.reverse
    |> String.to_charlist
    |> Enum.chunk(3)
    |> Path.join
  end
end
