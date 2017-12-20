defmodule HexletBasicsWeb.Plugs.AssignGlobalsToGon do
  import PhoenixGon.Controller
  # import Plug.Conn
  require Logger

  @spec init(Keyword.t) :: Keyword.t
  def init(opts), do: opts

  @spec call(Plug.Conn.t, Keyword.t) :: Plug.Conn.t
  def call(conn, _opts) do
    locale  = conn.assigns[:locale]
    current_user  = conn.assigns[:current_user]

    params = Application.fetch_env!(:hexlet_basics, String.to_atom(locale))
    keys = [:ga]
    configuration1 = Map.take(params, keys)
    configuration2 = %{locale: locale, current_user: current_user}
    configuration = Map.merge(configuration1, configuration2)
    Logger.info inspect ["Params For Gon", configuration]
    put_gon(conn, configuration)
  end
end

