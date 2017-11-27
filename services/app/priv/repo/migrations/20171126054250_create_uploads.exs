defmodule HexletBasics.Repo.Migrations.CreateUploads do
  use Ecto.Migration

  def change do
    create table(:uploads) do
      add :language_name, :string

      timestamps()
    end
  end
end
