defmodule HexletBasicsWeb.Plugs.AssignCurrentUser do
  import Plug.Conn
  import Phoenix.Controller
  alias HexletBasics.User

  @spec init(Keyword.t) :: Keyword.t
  def init(opts), do: opts

  @spec call(Plug.Conn.t, Keyword.t) :: Plug.Conn.t
  def call(conn, _opts) do
    maybeUser = get_session(conn, :current_user)
    user = case maybeUser do
      nil -> %User{ guest: true }
      u -> u
    end
    conn |> assign(:current_user, user)
  end
end
