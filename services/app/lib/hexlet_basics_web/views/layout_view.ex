defmodule HexletBasicsWeb.LayoutView do
  use HexletBasicsWeb, :view

  import PhoenixGon.View
  import HexletBasics.PageTitle

  def alert_name_by_flash(name) do
    map = %{
      info: 'info',
      error: 'danger'
    }

    map[name]
  end
end
