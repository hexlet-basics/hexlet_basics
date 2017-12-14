defmodule HexletBasics.Repo.Migrations.AddLanguageIdToLanguageModuleDescription do
  use Ecto.Migration

  def change do
    alter table("language_module_descriptions") do
      add :language_id, references("languages")
    end
  end
end
