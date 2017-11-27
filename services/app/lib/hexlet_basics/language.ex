defmodule HexletBasics.Language do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Language


  schema "languages" do
    field :name, :string
    field :slug, :string
    # field :upload_id, :id

    belongs_to :upload, HexletBasics.Upload

    timestamps()
  end

  @doc false
  def changeset(%Language{} = language, attrs) do
    language
    |> cast(attrs, [:name, :slug, :upload_id])
    # |> cast_assoc(:upload)
    |> validate_required([:name, :slug])
  end
end
