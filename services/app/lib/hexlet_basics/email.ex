defmodule HexletBasics.Email do
  use Bamboo.Phoenix, view: HexletBasicsWeb.EmailView


  def confirmation_text_email(email_address) do
        new_email()
        |> to(email_address)
        |> from("us@example.com")
        |> subject("Welcome!")
        # |> put_text_layout({HexletBasics.LayoutView, "email.text"})
        # |> render("user/confirmation.text", email_address: email_address)
      end

    def confirmation_html_email(email_address, confirmation_url) do
      email_address
      |> confirmation_text_email()
      |> put_html_layout({HexletBasicsWeb.LayoutView, "email.html"})
      |> render("user/confirmation.html",  email_address: email_address, confirmation_url: confirmation_url)
    end
end
