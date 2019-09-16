defmodule HexletBasics.Notifications.EmailBuilder do
  use Bamboo.Phoenix, view: HexletBasicsWeb.EmailView
  import HexletBasicsWeb.Gettext

  defp base_email(email_address, email, subject) do
    new_email()
    |> to(email_address)
    |> from({"Code Basics", sending_from()})
    |> subject(subject)
    |> put_private(:email_id, email.id)
    |> put_header("X-MSYS-API", %{metadata: %{email_id: email.id}})
    |> put_html_layout({HexletBasicsWeb.LayoutView, "email.html"})
  end

  def build_confirmation_html_email(conn, email, user, url) do
    subject = gettext("Confirm registration")
    %{assigns: %{locale: locale_from_conn}} = conn

    locale = user.locale || locale_from_conn
    email_address = user.email

    email_address
    |>base_email(email, subject)
    |> render(
      "user/confirmation.#{locale}.html",
      confirmation_url: url,
      subject: subject
    )
  end

  def build_reset_password_html_email(conn, email, user, url) do
    subject = gettext("Reset password")
    %{assigns: %{locale: locale_from_conn}} = conn

    locale = user.locale || locale_from_conn
    email_address = user.email

    email_address
    |>base_email(email, subject)
    |> render(
      "user/reset_password.#{locale}.html",
      reset_password_url: url,
      subject: subject
    )
  end

  defp sending_from do
    "basics.info@hexlet.io"
  end
end
