defmodule HexletBasics.Repo.Migrations.SetStateForUsers do
  use Ecto.Migration

  def change do
    HexletBasics.Repo.update_all(HexletBasics.User, set: [state: "active"])
  end
end
