defmodule HexletBasics.Language.Module do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Language.Module


  schema "language_modules" do
    field :slug, :string
    field :state, :string
    field :order, :integer
    field :language_id, :id

    belongs_to :upload, HexletBasics.Upload

    timestamps()
  end

  @doc false
  def changeset(%Module{} = module, attrs) do
    module
    |> cast(attrs, [:slug, :state, :order, :language_id, :upload_id])
    |> validate_required([:slug, :order])
  end
end
