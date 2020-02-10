defmodule HexletBasics.Repo.Migrations.MigrateEmailDelivieryStateForUser do
  use Ecto.Migration

  def change do
    HexletBasics.Repo.update_all(HexletBasics.User, set: [email_delivery_state: "enabled"])
  end
end
