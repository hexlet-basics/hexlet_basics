defmodule HexletBasicsWeb.Layout.SharedView do
  use HexletBasicsWeb, :view
  import PhoenixGon.View

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
end
