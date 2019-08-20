defmodule HexletBasics.Email do
  use Bamboo.Phoenix, view: HexletBasicsWeb.EmailView
  import HexletBasicsWeb.Gettext
  alias HexletBasicsWeb.Endpoint

  defp base_email(email_address, subject) do
    new_email()
    |> to(email_address)
    |> from({"Code Basics", sending_from()})
    |> subject(subject)
    |> put_html_layout({HexletBasicsWeb.LayoutView, "email.html"})
  end

  def confirmation_html_email(conn, email_address, url) do
    subject = gettext("Confirm registration")
    %{assigns: %{locale: locale}} = conn

    email_address
    |>base_email(subject)
    |> render(
      "user/confirmation.#{locale}.html",
      confirmation_url: url,
      subject: subject
    )
  end

  def reset_password_html_email(conn, email_address, url) do
    subject = gettext("Reset password")
    %{assigns: %{locale: locale}} = conn

    email_address
    |>base_email(subject)
    |> render(
      "user/reset_password.#{locale}.html",
      reset_password_url: url,
      subject: subject
    )
  end

  defp sending_from do
    sending_domain = Endpoint.config(:url)[:host]
    "noreply@#{sending_domain}"
  end
end
