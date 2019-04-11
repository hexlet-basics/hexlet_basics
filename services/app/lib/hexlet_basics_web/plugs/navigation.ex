defmodule HexletBasicsWeb.Plugs.Navigation do
  import Plug.Conn, only: [put_session: 3, get_session: 2]

  @session_key :internal_previous_path

  def init(opts) do
    Keyword.put_new(opts, :excluded_paths, [])
  end

  def call(conn, opts) do
    if conn.method == "GET" and not (conn.request_path in opts[:excluded_paths]) do
      put_previous_path(conn, conn.request_path)
    else
      conn
    end
  end

  def previous_path(conn, opts \\ []) do
    get_session(conn, @session_key) || opts[:default]
  end

  defp put_previous_path(conn, path) do
    if path != "/auth/github/callback" and path != "/auth/github" do
      put_session(conn, @session_key, path)
    else
      conn
    end
  end
end
