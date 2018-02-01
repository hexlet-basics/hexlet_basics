defmodule HexletBasics.Repo.Migrations.AddDefaultsToLanguageModuleLesson do
  use Ecto.Migration

  def change do
    alter table(:language_module_lesson_descriptions) do
      modify :tips, {:array, :string}, null: false, default: []
      modify :definitions, {:array, :map}, null: false, default: []
    end
  end
end
