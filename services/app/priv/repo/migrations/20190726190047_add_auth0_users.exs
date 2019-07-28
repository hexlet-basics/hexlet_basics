defmodule HexletBasics.Repo.Migrations.AddAuth0Users do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :auth0_uid, :string
    end
  end
end
