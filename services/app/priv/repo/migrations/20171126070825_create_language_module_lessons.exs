defmodule HexletBasics.Repo.Migrations.CreateLanguageModuleLessons do
  use Ecto.Migration

  def change do
    create table(:language_module_lessons) do
      add :name, :string
      add :slug, :string
      add :state, :string
      add :order, :integer
      add :language_module_id, references(:language_modules, on_delete: :nothing)
      add :language_id, references(:languages, on_delete: :nothing)
      add :upload_id, references(:uploads, on_delete: :nothing)

      timestamps()
    end

    create index(:language_module_lessons, [:language_module_id])
    create index(:language_module_lessons, [:language_id])
    create index(:language_module_lessons, [:upload_id])
  end
end
