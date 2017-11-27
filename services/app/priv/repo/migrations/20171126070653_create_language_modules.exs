defmodule HexletBasics.Repo.Migrations.CreateLanguageModules do
  use Ecto.Migration

  def change do
    create table(:language_modules) do
      add :slug, :string
      add :state, :string
      add :order, :integer
      add :language_id, references(:languages, on_delete: :nothing)
      add :upload_id, references(:uploads, on_delete: :nothing)

      timestamps()
    end

    create index(:language_modules, [:language_id])
    create index(:language_modules, [:upload_id])
  end
end
