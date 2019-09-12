defmodule HexletBasics.Notifier do
  alias HexletBasics.{Mailer, User}

  def send_email(email, recipient) do
    if User.enabled_delivery?(recipient) do
      email
      |> Mailer.deliver_now()
    end
  end
end
