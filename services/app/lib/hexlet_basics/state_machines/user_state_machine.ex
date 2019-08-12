defmodule HexletBasics.StateMachines.UserStateMachine do
  alias HexletBasics.{User, Repo}

  use Machinery,
    states: ["initial", "waiting_confirmation", "active", "inactive"],
    transitions: %{
      "initial" =>  ["waiting_confirmation", "inactive"],
      "waiting_confirmation" => "active",
      "*" => "inactive"
    }
end
