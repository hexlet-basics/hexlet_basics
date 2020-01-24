defmodule HexletBasicsWeb.LayoutView do
  use HexletBasicsWeb, :view

  import PhoenixGon.View
  import HexletBasics.PageTitle

  def locales_switch_map, do: %{"ru" => "en", "en" => "ru"}

  def alert_name_by_flash(name) do
    map = %{
      info: 'info',
      error: 'danger'
    }

    map[name]
  end

  def meta_tags(attrs_list) do
    Enum.map(attrs_list, &meta_tag/1)
  end

  def meta_tag(attrs) do
    tag(:meta, Enum.into(attrs, []))
  end

  def link_tags(attrs_list) do
    Enum.map(attrs_list, &link_tag/1)
  end

  def link_tag(attrs) do
    tag(:link, Enum.into(attrs, []))
  end

  def render_schema(schema) do
    Jason.encode!(schema)
  end
end
