defmodule HexletBasicsWeb.Api.Webhooks.SparkpostController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.UserManager

  def process(conn, _params) do
    try do
      events = conn.params["_json"]

      events
      |> Enum.filter(fn event -> !Enum.empty?(event["msys"]) end)
      |> Enum.each(
        fn
          %{"msys" => %{"message_event"=> body}} -> message_event_process(body)
          _ -> true
        end)
    rescue
      error in _ ->
        Rollbax.report(:error, error, __STACKTRACE__)
    end

    conn
    |> put_status(:ok)
    |> json("")
  end

  defp message_event_process(%{"rcpt_meta" => meta, "type" => type} = _body) do
    user = UserManager.get_user(meta["user_id"])
    if user do
      case type do
        "delivery" -> true
        "bounce" -> UserManager.disable_delivery!(user)
        "spam_complaint" -> UserManager.disable_delivery!(user)
        "policy_rejection" -> true
        _ -> nil
      end
    end
  end
  defp message_event_process(_), do: nil
end
