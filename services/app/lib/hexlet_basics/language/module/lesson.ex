defmodule HexletBasics.Language.Module.Lesson do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Language.Module.Lesson


  schema "language_module_lessons" do
    field :order, :integer
    field :slug, :string
    field :state, :string
    field :module_id, :id
    field :language_id, :id
    field :upload_id, :id
    field :original_code, :string
    field :prepared_code, :string
    field :test_code, :string

    timestamps()
  end

  @doc false
  def changeset(%Lesson{} = lesson, attrs) do
    lesson
    |> cast(attrs, [:slug, :order, :original_code, :prepared_code, :test_code])
    |> validate_required([:slug, :order, :original_code, :prepared_code, :test_code])
  end
end
