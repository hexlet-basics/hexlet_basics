defmodule HexletBasics.PageTitle do
  import Phoenix.Controller, only: [action_name: 1, view_module: 1]
  alias HexletBasicsWeb.{LanguageView, Language}

  @suffix "Code Basics (By Hexlet)"
  @separator " - "

  def page_title(assigns), do: assigns |> get |> put_suffix

  defp put_suffix(nil), do: @suffix
  defp put_suffix(title), do: Enum.join([title, @suffix], @separator)

  defp get(conn) do
    action = action_name(conn)
    view = view_module(conn)

    get_by_view(view, action, conn.assigns)
  end

  defp get_by_view(Language.Module.LessonView, action, assigns) do
    %{language: language, module_description: module_description} = assigns
    case action do
      :show -> Enum.join([assigns.lesson_description.name, module_description.name, language.name], @separator)
    end
  end

  defp get_by_view(LanguageView, action, assigns) do
    case action do
      :show -> assigns.language.name
    end
  end
  defp get_by_view(_, _, _), do: nil
  # defp get(%{ view_module: ArticleView, view_template: "show.html", article: article }) do
  #   article.title <> " - " <> article.series
  # end
end

