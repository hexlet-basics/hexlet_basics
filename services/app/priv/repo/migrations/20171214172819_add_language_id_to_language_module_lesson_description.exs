defmodule HexletBasics.Repo.Migrations.AddLanguageIdToLanguageModuleLessonDescription do
  use Ecto.Migration

  def change do
    alter table("language_module_lesson_descriptions") do
      add :language_id, references("languages")
    end
  end
end
