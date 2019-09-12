defmodule HexletBasics.Repo.Migrations.AddEmailDeliveryStateToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :email_delivery_state, :string
    end
  end
end
