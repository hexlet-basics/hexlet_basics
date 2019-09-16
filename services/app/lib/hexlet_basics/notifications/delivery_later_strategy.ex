defmodule HexletBasics.Notifications.DeliveryLaterStrategy do
  @behaviour Bamboo.DeliverLaterStrategy

  alias HexletBasics.Notifications
  alias HexletBasics.Repo

  def deliver_later(adapter, email_struct, config) do
    Task.async fn ->
      email_id = email_struct.private[:email_id]
      email = Repo.get(Notifications.Email, email_id)

      try do
        adapter.deliver(email_struct, config)
        Notifications.email_sent!(email)
      rescue
        e in _ ->
          Notifications.email_fail!(email)
          Rollbax.report(:error, e, __STACKTRACE__)
      end
    end
  end
end
