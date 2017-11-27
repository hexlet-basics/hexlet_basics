defmodule HexletBasicsWeb.LangController do
  use HexletBasicsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

