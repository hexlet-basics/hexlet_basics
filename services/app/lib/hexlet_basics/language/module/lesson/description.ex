defmodule HexletBasics.Language.Module.Lesson.Description do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.Language.Module.Lesson.Description

  @derive {Poison.Encoder, only: [:instructions, :theory, :name]}

  schema "language_module_lesson_descriptions" do
    field :instructions, :string
    field :locale, :string
    field :name, :string
    field :theory, :string
    # field :tips, { :list, :string }
    field :lesson_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Description{} = description, attrs) do
    description
    |> cast(attrs, [:theory, :instructions, :locale, :name])
    # |> cast_embed(attrs, :tips)
    |> validate_required([:theory, :instructions, :locale, :name])
  end
end
