defmodule HexletBasicsWeb.PageController do
  use HexletBasicsWeb, :controller

  def index(conn, _params) do
    languages = HexletBasics.Repo.all(HexletBasics.Language)
    render conn, "index.html", languages: languages
  end
end
