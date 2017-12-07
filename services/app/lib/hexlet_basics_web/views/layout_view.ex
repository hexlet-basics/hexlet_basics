defmodule HexletBasicsWeb.LayoutView do
  use HexletBasicsWeb, :view

  import PhoenixGon.View

  def alert_name_by_flash(name) do
    map = %{
      info: 'info',
      error: 'danger'
    }

    map[name]
  end
end
