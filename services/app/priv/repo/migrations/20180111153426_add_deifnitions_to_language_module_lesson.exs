defmodule HexletBasics.Repo.Migrations.AddDeifnitionsToLanguageModuleLesson do
  use Ecto.Migration

  def change do
    alter table(:language_module_lesson_descriptions) do
      add :definitions, {:array, :map}
    end
  end
end
