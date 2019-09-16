defmodule HexletBasics.Notifications.Email do
  use Ecto.Schema
  import Ecto.Changeset

  schema "emails" do
    field(:state, :string, default: "created")
    field(:kind, :string)
    field(:delivery_status, EmailDeliveryStatusEnum)
    field(:delivery_message, :string)
    field(:body, :string)
    belongs_to(:recipient, HexletBasics.User)

    timestamps()
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:delivery_status, :state, :kind, :delivery_message, :body])
    |> cast_assoc(:recipient)
  end
end
