defmodule HexletBasicsWeb.Plugs.DetectLocaleByHost do
  import Plug.Conn

  @spec init(Keyword.t()) :: Keyword.t()
  def init(options), do: options

  @spec call(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def call(conn, _) do
    cond do
      conn.host == System.fetch_env!("APP_RU_HOST") ->
        conn
        |> put_session(:locale, "ru")
      true ->
        conn
        |> put_session(:locale, "en")
    end
  end
end
