defmodule HexletBasics.StateMachines.User.EmailDeliveryStateMachine do
  use Machinery,
    field: :email_delivery_state,
    states: ["enabled", "disabled"],
    transitions: %{
      "enabled" =>  "disabled",
      "disabled" => "enabled"
    }
end
