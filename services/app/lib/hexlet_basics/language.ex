defmodule HexletBasics.Language do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Language

  @derive {Poison.Encoder, only: [:name, :slug]}

  schema "languages" do
    field :name, :string
    field :slug, :string
    field :extension, :string
    field :docker_image, :string
    field :exercise_filename, :string
    field :exercise_test_filename, :string

    belongs_to :upload, HexletBasics.Upload

    timestamps()
  end

  @doc false
  def changeset(%Language{} = language, attrs) do
    language
    |> cast(attrs, [:name, :slug, :upload_id, :extension, :exercise_filename, :exercise_test_filename, :docker_image])
    # |> cast_assoc(:upload)
    |> validate_required([:name, :slug, :extension, :exercise_filename, :exercise_test_filename, :docker_image])
    # |> unique_constraint(:slug, message: "JOPA!")
  end
end
