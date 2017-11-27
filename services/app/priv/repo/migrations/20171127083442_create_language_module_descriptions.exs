defmodule HexletBasics.Repo.Migrations.CreateLanguageModuleDescriptions do
  use Ecto.Migration

  def change do
    create table(:language_module_descriptions) do
      add :name, :string
      add :description, :text
      add :locale, :string
      add :language_module_id, references(:language_modules, on_delete: :nothing)

      timestamps()
    end

    create index(:language_module_descriptions, [:language_module_id])
  end
end
