defmodule HexletBasics.User.FinishedLesson do
  use Ecto.Schema
  import Ecto.Changeset
  alias HexletBasics.User.FinishedLesson

  @derive {Poison.Encoder, only: [:id]}

  schema "user_finished_lessons" do
    belongs_to(:user, HexletBasics.User)
    belongs_to(:language_module_lesson, HexletBasics.Language.Module.Lesson)
    # field :language_module_lesson_id, :id

    timestamps()
  end

  @doc false
  def changeset(%FinishedLesson{} = finished_lesson, attrs) do
    finished_lesson
    |> cast(attrs, [:user_id, :language_module_lesson_id])
    |> validate_required([:user_id, :language_module_lesson_id])
  end
end
