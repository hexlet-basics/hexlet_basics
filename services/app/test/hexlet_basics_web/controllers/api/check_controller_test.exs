defmodule HexletBasicsWeb.Api.CheckControllerTest do
  import Plug.Conn
  use HexletBasicsWeb.ConnCase

  test "create", %{conn: conn} do
    data = %{
      attributes: %{
        code: "code!"
      }
    }
    user = insert(:user)
    conn = conn
    |> put_session(:current_user, user)
    |> post(check_path(conn, :create), data: data)

    assert json_response(conn, 200)
  end
end
