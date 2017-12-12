defmodule HexletBasicsWeb.Language.ModuleController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo
  alias HexletBasics.Language
  import Ecto.Query

  def show(conn, %{"id" => id, "language_id" => language_id}) do
    language = Repo.get_by(Language, slug: language_id)
    module = Repo.get_by(Language.Module, language_id: language.id, slug: id)

    query = from l in Language.Module.Lesson,
      where: l.language_id == ^language.id and l.upload_id == ^language.upload_id and l.module_id == ^module.id,
      order_by: [asc: l.order]
    lessons = Repo.all(query)
    render conn, language: language, module: module, lessons: lessons
  end
end

