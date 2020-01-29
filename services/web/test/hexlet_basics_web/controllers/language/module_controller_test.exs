defmodule HexletBasicsWeb.Language.ModuleControllerTest do
  use HexletBasicsWeb.ConnCase

  test "show", %{conn: conn} do
    module = insert(:language_module)
    language = module.language
    conn = get conn, language_module_path(conn, :show, language.slug, module.slug)
    assert html_response(conn, 200)
  end
end

