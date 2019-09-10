defmodule HexletBasicsWeb.Api.Webhooks.SparkpostController do
  use HexletBasicsWeb, :controller

  def process(conn, _params) do
    conn
    |> send_resp(200, "")
  end
end
