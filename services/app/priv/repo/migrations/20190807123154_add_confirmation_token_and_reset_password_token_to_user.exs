defmodule HexletBasics.Repo.Migrations.AddConfirmationTokenAndResetPasswordTokenToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :confirmation_token, :string
      add :reset_password_token, :string
    end
  end
end
