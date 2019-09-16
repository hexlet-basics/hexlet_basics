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
      email = email_sending!(email)

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
    end
  end

  def email_processing!(email) do
    state = email_change_state(email, "processing")
    update_email!(email, %{state: state})
  end

  def email_sending!(email) do
    state = email_change_state(email, "sending")
    update_email!(email, %{state: state})
  end

  def email_fail!(email) do
    state = email_change_state(email, "failed")
    update_email!(email, %{state: state})
  end

  def email_sent!(email) do
    state = email_change_state(email, "sent")
    update_email!(email, %{state: state})
  end

  defp email_change_state(email, state) do
    {:ok, %Email{state: state}} = Machinery.transition_to(email, EmailStateMachine, state)
    state
  end
end
