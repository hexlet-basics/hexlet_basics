defmodule HexletBasics.Repo.Migrations.AddLocaleForUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :locale, :string
    end
  end
end
