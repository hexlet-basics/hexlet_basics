defmodule HexletBasics.Email do
  use Bamboo.Phoenix, view: HexletBasicsWeb.EmailView
  import HexletBasicsWeb.Gettext
  import HexletBasicsWeb.Helpers.CustomUrl

  def confirmation_html_email(conn, email_address, path) do
    subject = gettext("Confirm registration")
    %{assigns: %{locale: locale}} = conn
    url = build_url(conn, path)

    new_email()
    |> to(email_address)
    |> from(sending_from(conn))
    |> subject(subject)
    |> put_html_layout({HexletBasicsWeb.LayoutView, "email.html"})
    |> render(
      "user/confirmation.#{locale}.html",
      confirmation_url: url,
      subject: subject)
  end

  def reset_password_html_email(conn, email_address, path) do
    subject = gettext("Reset password")
    url = build_url(conn, path)
    %{assigns: %{locale: locale}} = conn

    new_email()
    |> to(email_address)
    |> from(sending_from(conn))
    |> subject(subject)
    |> put_html_layout({HexletBasicsWeb.LayoutView, "email.html"})
    |> render(
      "user/reset_password.#{locale}.html",
      reset_password_url: url,
      subject: subject)
  end

  defp sending_from(conn) do
    "noreply@#{conn.host}"
  end
end
