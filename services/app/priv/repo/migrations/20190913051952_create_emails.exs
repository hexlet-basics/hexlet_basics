defmodule HexletBasics.Repo.Migrations.CreateEmails do
  use Ecto.Migration

  def change do
    EmailDeliveryStatusEnum.create_type
    create table(:emails) do
      add :state, :string
      add :delivery_status, EmailDeliveryStatusEnum.type()
      add :delivery_message, :text
      add :kind, :string
      add :body, :text
      add :sent_at, :utc_datetime
      add :recipient_id, references(:users, on_delete: :nothing)

      timestamps()
    end
  end
end
