defmodule HexletBasicsWeb.Plugs.SetUrl do
  import Plug.Conn
  alias HexletBasicsWeb.Helpers.CustomUrl
  use HexletBasicsWeb, :controller

  def init(options), do: options

  def call(conn, _) do
    %{assigns: %{locale: locale}} = conn

    conn
    |> put_router_url(CustomUrl.url_by_lang(locale))
  end
end
