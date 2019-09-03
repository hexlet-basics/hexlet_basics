defmodule HexletBasics.Repo.Migrations.CreateUserAccounts do
  use Ecto.Migration

  def change do
    create table(:user_accounts) do
      add :user_id, references(:users), null: false
      add :provider, :string, null: false
      add :uid, :string, null: false

      timestamps()
    end
  end
end
