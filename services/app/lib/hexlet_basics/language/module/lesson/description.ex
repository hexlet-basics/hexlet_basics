defmodule HexletBasics.Language.Module.Lesson.Description do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Language
  alias HexletBasics.Language.Module.Lesson.Description
  alias HexletBasics.Language.Module.Lesson

  @derive {Poison.Encoder, only: [:instructions, :theory, :name]}

  schema "language_module_lesson_descriptions" do
    field(:instructions, :string)
    field(:locale, :string)
    field(:name, :string)
    field(:theory, :string)
    field(:tips, {:array, :string}, default: [])
    field(:definitions, {:array, :map}, default: [])
    belongs_to(:lesson, Lesson)
    belongs_to(:language, Language)

    timestamps()
  end

  @doc false
  def changeset(%Description{} = description, attrs) do
    description
    |> cast(attrs, [
      :theory,
      :instructions,
      :locale,
      :name,
      :lesson_id,
      :language_id,
      :tips,
      :definitions
    ])
    # |> cast_embed(attrs, :tips)
    |> validate_required([:theory, :instructions, :locale, :name, :lesson_id, :language_id])
  end
end
