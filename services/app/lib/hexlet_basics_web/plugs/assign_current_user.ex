defmodule HexletBasicsWeb.Plugs.AssignCurrentUser do
  import Plug.Conn

  alias HexletBasics.User
  alias HexletBasics.UserManager

  @spec init(Keyword.t()) :: Keyword.t()
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def call(conn, _opts) do
    # FIXME: Это нужно будет убрать когда вернем аутентификацию для соцсетей
    user_from_session = get_session(conn, :current_user)
    conn = cond do
      user_from_session && !user_from_session.guest ->
        renew_user = UserManager.get_user!(user_from_session.id)
        conn
        |> put_session(:current_user, renew_user)
      true ->
        conn
    end

    maybe_user = get_session(conn, :current_user) || Guardian.Plug.current_resource(conn)

    user =
      case maybe_user do
        nil -> %User{guest: true, nickname: nil, locale: nil}
        u -> u
      end

    conn |> assign(:current_user, user)
  end
end
