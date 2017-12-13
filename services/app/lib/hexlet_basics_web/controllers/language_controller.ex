defmodule HexletBasicsWeb.LanguageController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo, as: Repo
  alias HexletBasics.Language, as: Language
  import Ecto.Query

  def show(conn, %{"id" => id}) do
    language = Repo.get_by(HexletBasics.Language, slug: id)
    query = from m in Language.Module,
      where: m.language_id == ^language.id and m.upload_id == ^language.upload_id,
      order_by: [asc: m.order]
    modules = Repo.all(query)
              |> Repo.preload(lessons: from(Language.Module.Lesson, order_by: [asc: :order]))

    # TODO add langauge_id
    description_query = from d in Language.Module.Description,
      where: d.locale == ^conn.assigns[:locale]
    descriptions = Repo.all(description_query)
    descriptions_by_module = descriptions
                             |> Enum.reduce(%{}, &(Map.put(&2, &1.module_id, &1)))

    render conn, language: language, modules: modules, descriptions_by_module: descriptions_by_module
  end
end

