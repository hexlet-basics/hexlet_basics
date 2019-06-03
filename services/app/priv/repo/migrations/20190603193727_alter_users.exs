defmodule HexletBasics.Repo.Migrations.AlterUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :facebook_uid, :string
    end
  end
end
