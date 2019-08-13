defmodule HexletBasicsWeb.Plugs.AssignCurrentUser do
  import Plug.Conn

  alias HexletBasics.User

  @spec init(Keyword.t()) :: Keyword.t()
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def call(conn, _opts) do
    maybe_user = get_session(conn, :current_user) || Guardian.Plug.current_resource(conn)

    user =
      case maybe_user do
        nil -> %User{guest: true, nickname: nil}
        u -> u
      end

    conn |> assign(:current_user, user)
  end
end
