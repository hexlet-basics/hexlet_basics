defmodule HexletBasics.StateMachines.UserStateMachine do
  use Machinery,
    states: ["initial", "waiting_confirmation", "active", "inactive"],
    transitions: %{
      "initial" =>  ["waiting_confirmation", "inactive", "active"],
      "waiting_confirmation" => "active",
      "*" => "inactive"
    }
end
