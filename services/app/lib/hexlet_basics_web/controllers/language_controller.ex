defmodule HexletBasicsWeb.LanguageController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo, as: Repo
  alias HexletBasics.Language, as: Language
  import Ecto.Query

  def index(conn, _params) do
    render conn
  end

  def show(conn, %{ "id" => id }) do
    language = Repo.get_by(HexletBasics.Language, slug: id)
    query = from m in Language.Module,
      where: m.language_id == ^language.id and m.upload_id == ^language.upload_id,
      order_by: [asc: m.order]
    modules = Repo.all(query)

    render conn, language: language, modules: modules
  end
end

