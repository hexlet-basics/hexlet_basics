defmodule HexletBasicsWeb.SessionController do
  use HexletBasicsWeb, :controller

  def delete(conn, _params) do
    conn
    |> put_flash(:info, gettext "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def logout(conn, _params) do
    query = %{ returnTo: url(conn, Routes.page_path(conn, :index)), client_id: System.get_env("AUTH0_CLIENT_ID") }
    logout_url = %URI{
      host: System.get_env("AUTH0_DOMAIN"),
      path: '/v2/logout',
      query: URI.encode_query(query),
      scheme: "https"
    }
    conn
    |> put_flash(:info, gettext "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(external: to_string(logout_url))
  end

  def url(conn, path) do
    "#{conn.scheme}://#{conn.host}#{path}"
  end

end
