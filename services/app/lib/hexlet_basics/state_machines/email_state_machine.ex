defmodule HexletBasics.StateMachines.EmailStateMachine do
  alias HexletBasics.Notifications.Email

  use Machinery,
    states: ["created", "processing", "sending", "sent", "failed"],
    transitions: %{
      "created" => "processing",
      "processing" => "sending",
      "sending" => ["sent", "failed"],
    }

  def before_transition(struct, "sent") do
    %Email{struct | sent_at: DateTime.utc_now}
  end
end
