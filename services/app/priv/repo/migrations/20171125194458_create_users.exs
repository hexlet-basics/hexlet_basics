defmodule HexletBasics.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :nickname, :string
      add :github_uid, :integer

      timestamps()
    end

  end
end
