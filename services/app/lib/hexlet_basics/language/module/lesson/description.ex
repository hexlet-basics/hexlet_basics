defmodule HexletBasics.Language.Module.Lesson.Description do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Language.Module.Lesson.Description


  schema "language_module_lesson_descriptions" do
    field :instructions, :string
    field :locale, :string
    field :theory, :string
    field :tips, :string
    field :language_module_lesson_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Description{} = description, attrs) do
    description
    |> cast(attrs, [:theory, :instructions, :locale, :tips])
    |> validate_required([:theory, :instructions, :locale, :tips])
  end
end
