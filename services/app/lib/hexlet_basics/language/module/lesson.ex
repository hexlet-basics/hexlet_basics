defmodule HexletBasics.Language.Module.Lesson do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Language.Module.Lesson


  schema "language_module_lessons" do
    field :order, :integer
    field :slug, :string
    field :state, :string
    field :original_code, :string
    field :prepared_code, :string
    field :test_code, :string

    belongs_to :language, HexletBasics.Language
    belongs_to :module, HexletBasics.Language.Module
    belongs_to :upload, HexletBasics.Upload

    timestamps()
  end

  @doc false
  def changeset(%Lesson{} = lesson, attrs) do
    lesson
    |> cast(attrs, [:slug, :order, :original_code, :prepared_code, :test_code, :language_id, :module_id, :upload_id])
    |> validate_required([:slug, :order, :original_code, :prepared_code, :test_code])
  end
end
