defmodule HexletBasicsWeb.Plugs.SubdomainRedirects do
  import Plug.Conn
  use HexletBasicsWeb, :controller

  def init(options), do: options

  def call(conn, _) do
    %{assigns: %{locale: locale}} = conn

    cond do
      conn.host == System.get_env("APP_RU_HOST") ->
        conn
      locale == "ru" ->
        cur_path = current_path(conn)
        redirect_url = Routes.url(%URI{scheme: System.get_env("APP_SCHEME"), host: System.get_env("APP_RU_HOST")}) <> cur_path

        conn
        |> redirect(external: redirect_url)
        |> halt()
      true ->
        conn
    end
  end
end
