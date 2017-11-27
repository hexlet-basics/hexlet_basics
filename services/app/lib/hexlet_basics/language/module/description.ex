defmodule HexletBasics.Language.Module.Description do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Language.Module.Description


  schema "language_module_descriptions" do
    field :description, :string
    field :locale, :string
    field :name, :string
    field :module_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Description{} = description, attrs) do
    description
    |> cast(attrs, [:name, :description, :locale])
    |> validate_required([:name, :description, :locale])
  end
end
