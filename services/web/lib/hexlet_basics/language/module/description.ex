defmodule HexletBasics.Language.Module.Description do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Language
  alias HexletBasics.Language.Module


  schema "language_module_descriptions" do
    field :description, :string
    field :locale, :string
    field :name, :string
    belongs_to :module, Module
    belongs_to :language, Language

    timestamps()
  end

  @doc false
  def changeset(%Module.Description{} = description, attrs) do
    description
    |> cast(attrs, [:name, :description, :locale, :language_id, :module_id])
    |> cast_assoc(:module)
    |> validate_required([:name, :description, :locale, :language_id, :module_id])
  end
end
