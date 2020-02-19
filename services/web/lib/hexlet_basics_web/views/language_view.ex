defmodule HexletBasicsWeb.LanguageView do
  use HexletBasicsWeb, :view

  # FIXME: remove after fix views loading
  # def locales_switch_map, do: %{"ru" => "en", "en" => "ru"}
  # def description_on_github_cpath(conn, lesson) do
  # end

  def hexlet_profession_cpath(language) do
    hexlet_professions_map = %{
      "javascript" => "frontend",
      "python" => "python",
      "php" => "php",
      "html" => "layout-designer",
      "css" => "layout-designer",
      "java" => "java"
    }
    if Map.has_key?(hexlet_professions_map, language) do
      "/professions/" <> hexlet_professions_map[language]
    else
      "/professions"
    end
  end
end
