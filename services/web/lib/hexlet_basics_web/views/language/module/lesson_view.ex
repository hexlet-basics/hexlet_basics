defmodule HexletBasicsWeb.Language.Module.LessonView do
  use HexletBasicsWeb, :view

  # TODO Extract to shared
  def locales_switch_map, do: %{"ru" => "en", "en" => "ru"}

  def description_on_github_cpath(conn, lesson) do
    repository_name = "exercises-#{lesson.module.language.slug}"
    module_dir_name = "#{lesson.module.order}-#{lesson.module.slug}"
    lesson_dir_name = "#{lesson.order}-#{lesson.slug}"
    locale = conn.assigns.locale

    "https://github.com/hexlet-basics/#{repository_name}/blob/master/modules/#{module_dir_name}/#{lesson_dir_name}/description.#{locale}.yml"
  end

end

