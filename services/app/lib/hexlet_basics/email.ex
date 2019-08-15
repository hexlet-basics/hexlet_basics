defmodule HexletBasics.Email do
  use Bamboo.Phoenix, view: HexletBasicsWeb.EmailView
  import HexletBasicsWeb.Gettext
  import HexletBasicsWeb.Helpers.CustomUrl

  def base_email(email_address, conn, subject) do
    new_email()
    |> to(email_address)
    |> from({"Code Basics", sending_from(conn) })
    |> subject(subject)
    |> put_html_layout({HexletBasicsWeb.LayoutView, "email.html"})
  end

  def confirmation_html_email(conn, email_address, path) do
    subject = gettext("Confirm registration")
    %{assigns: %{locale: locale}} = conn
    url = build_url(conn, path)

    email_address
    |>base_email(conn, subject)
    |> render(
      "user/confirmation.#{locale}.html",
      confirmation_url: url,
      subject: subject)
  end

  def reset_password_html_email(conn, email_address, path) do
    subject = gettext("Reset password")
    url = build_url(conn, path)
    %{assigns: %{locale: locale}} = conn

    email_address
    |>base_email(conn, subject)
    |> render(
      "user/reset_password.#{locale}.html",
      reset_password_url: url,
      subject: subject)
  end

  defp sending_from(conn) do
    "noreply@#{conn.host}"
  end
end
