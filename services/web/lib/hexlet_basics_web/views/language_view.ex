defmodule HexletBasicsWeb.LanguageView do
  use HexletBasicsWeb, :view

  def hexlet_professions_map(slug) do
    map = %{
      "javascript" => "frontend",
      "python" => "python",
      "php" => "php",
      "html" => "layout-designer",
      "css" => "layout-designer",
      "java" => "java"
    }
    if Map.has_key?(map, slug), do: map[slug], else: nil
  end

  def hexlet_profession_cpath(language) do
    lang = hexlet_professions_map(language)
    if lang, do: "/professions/#{lang}", else: "/professions"
  end

  def profession_static_cpath(language) do
    lang = hexlet_professions_map(language)
    if lang do
      "/images/prof_icons/#{lang}.svg"
    else
      "/images/logo.png"
    end
  end
end
