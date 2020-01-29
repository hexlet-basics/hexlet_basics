defmodule HexletBasicsWeb.SessionController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.{UserManager, UserManager.Guardian}
  alias HexletBasicsWeb.Plugs.CheckAuthentication
  alias HexletBasicsWeb.Plugs.DetectLocaleByHost

  plug DetectLocaleByHost when action in [:new]
  plug CheckAuthentication when action in [:new, :create]

  def new(conn, _params) do
    meta_attrs = [
      %{property: "og:type", content: 'website'},
      %{property: "og:title", content: gettext("Code Basics Login Title")},
      %{property: "og:description", content: gettext("Code Basics Login Description")},
      %{property: "og:image", content: Routes.static_url(conn, "/images/logo.png")},
      %{property: "og:url", content: Routes.page_url(conn, :index)},
      %{property: "description", content: gettext("Code Basics Login Description")},
      %{property: "image", content: Routes.static_url(conn, "/images/logo.png")}
    ]
    link_attrs = [
      %{rel: "canonical", href: Routes.page_url(conn, :index)},
      %{rel: 'image_src', href: Routes.static_url(conn, "/images/logo.png")}
    ]

    title_text = gettext("Code Basics Login Title")

    render(conn, "new.html", link_attrs: link_attrs, meta_attrs: meta_attrs, title: title_text)
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    auth = UserManager.authenticate_user(String.trim(email), password)

    auth
    |> login_reply(conn)
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> clear_session
    |> put_flash(:info, gettext("You have been logged out!"))
    |> redirect(to: "/")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:info, gettext("Signed in successfully."))
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp login_reply({:error, _reason}, conn) do
    conn
    |> put_flash(:error, gettext("There was a problem with your email/password"))
    |> new(%{})
  end
end
