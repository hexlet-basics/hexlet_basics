defmodule HexletBasicsWeb.AuthControllerTest do
  use HexletBasicsWeb.ConnCase, async: true

  test "/auth/github/callback ueberauth failure", %{conn: conn} do
    failure_conn = Map.put(conn, :assigns, %{ueberauth_failure: %{}})
    conn = get(failure_conn, "/auth/github/callback")

    assert conn.state == :sent
    assert redirected_to(conn) == "/"
  end
end
