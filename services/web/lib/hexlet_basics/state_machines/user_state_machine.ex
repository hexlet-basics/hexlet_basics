defmodule HexletBasics.StateMachines.UserStateMachine do
  use Machinery,
    states: ["initial", "waiting_confirmation", "active", "removed"],
    transitions: %{
      "initial" =>  ["waiting_confirmation", "active"],
      "waiting_confirmation" => "active",
      "active" => "active",
      "*" => "removed"
    }
end
