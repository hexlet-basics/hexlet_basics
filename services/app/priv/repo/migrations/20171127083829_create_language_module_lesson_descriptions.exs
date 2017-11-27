defmodule HexletBasics.Repo.Migrations.CreateLanguageModuleLessonDescriptions do
  use Ecto.Migration

  def change do
    create table(:language_module_lesson_descriptions) do
      add :theory, :text
      add :instructions, :text
      add :locale, :string
      add :tips, { :array, :string }
      add :lesson_id, references(:language_module_lessons, on_delete: :nothing)

      timestamps()
    end

    create index(:language_module_lesson_descriptions, [:lesson_id])
  end
end
