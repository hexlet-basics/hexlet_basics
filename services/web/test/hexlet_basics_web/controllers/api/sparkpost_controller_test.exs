defmodule HexletBasicsWeb.Api.SparkpostControllerTest do
  use HexletBasicsWeb.ConnCase, async: true
  alias HexletBasics.{User, UserManager}

  setup [:prepare_events]

  test "process", %{conn: conn, disabled_delivery_user: disabled_delivery_user, delivery_user: delivery_user, spam_user: spam_user, events: events} do
    conn =
      conn
      |> put_req_header("content-type", "application/json")
      |> post(sparkpost_path(conn, :process), Jason.encode!(events))

    disabled_delivery_user = UserManager.get_user!(disabled_delivery_user.id)
    spam_user = UserManager.get_user!(spam_user.id)
    delivery_user = UserManager.get_user!(delivery_user.id)

    assert json_response(conn, 200)
    assert User.disabled_delivery?(disabled_delivery_user)
    assert User.disabled_delivery?(spam_user)
    assert User.enabled_delivery?(delivery_user)
  end

  def prepare_events(_) do
    disabled_delivery_user = insert(:user)
    delivery_user = insert(:user)
    spam_user = insert(:user)
    events = %{"_json" =>
      [
        %{
          msys: %{
            message_event: %{
              type: "bounce",
              rcpt_meta: %{
                user_id: disabled_delivery_user.id
              }
            }
          }
        },
        %{
          msys: %{
            message_event: %{
              type: "spam_complaint",
              rcpt_meta: %{
                user_id: spam_user.id
              }
            }
          }
        },
        %{ msys: %{
            message_event: %{
              type: "delivery",
              rcpt_meta: %{
                user_id: delivery_user.id
              }
            }
          }
        }
      ]
    }
    {:ok, disabled_delivery_user: disabled_delivery_user, delivery_user: delivery_user, events: events, spam_user: spam_user}
  end
end

