defmodule HexletBasics.User.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_accounts" do
    field(:provider, :string)
    field(:uid, :string)
    belongs_to(:user, HexletBasics.User)

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:provider, :uid, :user_id])
    |> validate_required([:provider, :uid, :user_id])
  end
end
