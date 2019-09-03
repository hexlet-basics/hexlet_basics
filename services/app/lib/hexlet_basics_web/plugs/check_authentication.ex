defmodule HexletBasicsWeb.Plugs.CheckAuthentication do
  import Plug.Conn
  use HexletBasicsWeb, :controller

  @spec init(Keyword.t()) :: Keyword.t()
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def call(conn, _opts) do
    %{assigns: %{current_user: current_user}} = conn

    if current_user.guest do
      conn
    else
      conn
      |> redirect(to: "/")
      |> halt()
    end 
  end
end
