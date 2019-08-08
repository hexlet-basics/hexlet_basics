defmodule HexletBasicsWeb.Helpers.CustomUrl do
  def build_url(conn, path) do
    "#{conn.scheme}://#{conn.host}#{path}"
  end
end
