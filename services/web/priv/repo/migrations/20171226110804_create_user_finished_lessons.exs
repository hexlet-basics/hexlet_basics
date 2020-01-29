defmodule HexletBasics.Repo.Migrations.CreateUserFinishedLessons do
  use Ecto.Migration

  def change do
    create table(:user_finished_lessons) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :language_module_lesson_id, references(:language_module_lessons, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:user_finished_lessons, [:user_id])
    create index(:user_finished_lessons, [:language_module_lesson_id])

    create index(:user_finished_lessons, [:user_id, :language_module_lesson_id], unique: true)
  end
end
