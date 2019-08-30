defmodule HexletBasicsWeb.Plugs.AssignGlobals do
  @moduledoc false
  import PhoenixGon.Controller
  import Plug.Conn
  require Logger

  @spec init(Keyword.t) :: Keyword.t
  def init(opts), do: opts

  @spec call(Plug.Conn.t, Keyword.t) :: Plug.Conn.t
  def call(conn, _opts) do
    %{assigns: %{current_user: current_user, locale: locale}} = conn

   configuration1 = [:ga, :gtm]
                     |> Enum.reduce(%{}, fn key, acc ->
                       value = Application.fetch_env!(:hexlet_basics, key)
                       Map.put(acc, key, value)
                     end)

    disqus_local_key = String.to_atom("disqus_#{locale}")
    disqus_value = Application.fetch_env!(:hexlet_basics, disqus_local_key)

    configuration2 = %{locale: locale, current_user: current_user, disqus: disqus_value}
    configuration = Map.merge(configuration1, configuration2)
    Logger.info inspect ["Params For Gon", configuration]

    conn
    |> put_gon(configuration)
    |> assign(:ga, configuration1.ga)
    |> assign(:gtm, configuration1.gtm)
    |> assign(:meta_attrs, [])
    |> assign(:link_attrs, [])
    |> assign(:title, Gettext.gettext(HexletBasicsWeb.Gettext, "Code Basics Title"))
  end
end
