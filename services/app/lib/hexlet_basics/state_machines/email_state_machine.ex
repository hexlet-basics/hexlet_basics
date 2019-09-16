defmodule HexletBasics.StateMachines.EmailStateMachine do
  use Machinery,
    states: ["created", "processing", "sending", "sent", "failed"],
    transitions: %{
      "created" => "processing",
      "processing" => "sending",
      "sending" => ["sent", "failed"],
    }
end
