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

    # TODO add langauge_id
    # descriptions = Repo.get_by(Language.Module.Description, locale: conn.assigns.locale)
    # descriptions_by_module = descriptions

    render conn, language: language, modules: modules, descriptions_by_module: descriptions_by_module
  end
end

