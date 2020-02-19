defmodule HexletBasicsWeb.LayoutView do
  use HexletBasicsWeb, :view
  # import HexletBasics.PageTitle

  def locales_switch_map, do: %{"ru" => "en", "en" => "ru"}

  def alert_name_by_flash(name) do
    map = %{
      info: 'info',
      error: 'danger'
    }

    map[name]
  end

  def render_schema(schema) do
    Jason.encode!(schema)
  end
end
