defmodule HexletBasicsWeb.LanguageController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo, as: Repo

  def index(conn, _params) do
    render conn
  end

  def show(conn, %{ "id" => id }) do
    language = Repo.get_by(HexletBasics.Language, slug: id)
    modules = Repo.all(HexletBasics.Language.Module, language_id: language.id)
    render conn, language: language, modules: modules
  end
end

