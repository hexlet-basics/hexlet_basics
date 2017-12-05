defmodule HexletBasicsWeb.Api.CheckControllerTest do
  use HexletBasicsWeb.ConnCase

  test "create", %{conn: conn} do
    conn = get conn, check_path(conn, :create)
    assert json_response(conn, 200)
  end
end
