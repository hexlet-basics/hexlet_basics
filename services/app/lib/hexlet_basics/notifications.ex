defmodule HexletBasics.Notifications do
  alias HexletBasics.{User, Repo}
  alias HexletBasics.StateMachines.{EmailStateMachine}
  alias HexletBasics.Notifications.{Email, EmailBuilder, Mailer}
  alias HexletBasicsWeb.Router.Helpers, as: Routes

  def update_email!(email, attrs \\ %{}) do
    email
    |> Email.changeset(attrs)
    |> Repo.update!()
  end

  def send_email(email, conn, recipient) do
    email = email_processing!(email)
    email_struct = build_html_email(email, conn, recipient)

    email = update_email!(email, %{body: email_struct.html_body})

    if User.enabled_delivery?(recipient) do
      email_sending!(email)

      email_struct
      |> Mailer.deliver_later()
    end
  end

  defp build_html_email(email, conn, recipient) do
    case email.kind do
      "user_registration" -> 
          EmailBuilder.build_confirmation_html_email(
            conn,
            email,
            recipient,
            Routes.user_url(conn, :confirm, confirmation_token: recipient.confirmation_token)
          )
      "remind_password" ->
        EmailBuilder.build_reset_password_html_email(
          conn,
          email,
          recipient,
          Routes.password_url(conn, :edit, reset_password_token: recipient.reset_password_token)
        )
    end
  end

  def email_processing!(email) do
    struct = email_change_state(email, "processing")
    update_email!(email, %{state: struct.state})
  end

  def email_sending!(email) do
    struct = email_change_state(email, "sending")
    update_email!(email, %{state: struct.state})
  end

  def email_fail!(email) do
    struct = email_change_state(email, "failed")
    update_email!(email, %{state: struct.state})
  end

  def email_sent!(email) do
    struct = email_change_state(email, "sent")
    update_email!(email, %{state: struct.state, sent_at: struct.sent_at})
  end

  defp email_change_state(email, state) do
    {:ok, email} = Machinery.transition_to(email, EmailStateMachine, state)
    email
  end
end
