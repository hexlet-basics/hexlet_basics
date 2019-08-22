defmodule HexletBasicsWeb.Plugs.Subdomain do
    import Plug.Conn

    @doc false
    def init(default), do: default

    @doc false
    def call(conn, router) do
          case get_subdomain(conn.host) do
                  subdomain when byte_size(subdomain) > 0 ->
                      conn
                      |> put_private(:subdomain, subdomain)
                    _ -> conn
                  end
        end

    defp get_subdomain(host) do
    root_host = HexletBasicsWeb.Endpoint.config(:url)[:host]
    String.replace(host, ~r/.?#{root_host}/, "")
  end
end
