defmodule HexletBasics.Language.Module.Lesson do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Language.Module.Lesson


  schema "language_module_lessons" do
    field :locale, :string
    field :name, :string
    field :order, :integer
    field :slug, :string
    field :state, :string
    field :language_module_id, :id
    field :language_id, :id
    field :language_upload_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Lesson{} = lesson, attrs) do
    lesson
    |> cast(attrs, [:name, :slug, :state, :locale, :order])
    |> validate_required([:name, :slug, :state, :locale, :order])
  end
end
