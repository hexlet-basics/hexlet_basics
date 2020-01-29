defmodule HexletBasicsWeb.AuthControllerTest do
  use HexletBasicsWeb.ConnCase, async: true

  test "/auth/github/callback ueberauth failure", %{conn: conn} do
    failure_conn = Map.put(conn, :assigns, %{ueberauth_failure: %{}})
    conn = get(failure_conn, "/auth/github/callback")

    assert conn.state == :sent
    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "when callback succeeds" , %{conn: conn} do
    auth = %Ueberauth.Auth{
      provider: :github,
      uid: 12345,
      info: %{
        nickname: "johndoe",
        email: "john.doe@example.com",
      }
    }

    conn =
      conn
      |> bypass_through(HexletBasicsWeb.Router, [:browser])
      |> get("/auth/github/callback", code: "12345")
      |> assign(:ueberauth_auth, auth)
      |> HexletBasicsWeb.AuthController.callback(%{})

    assert redirected_to(conn) == page_path(conn, :index)
  end
end
