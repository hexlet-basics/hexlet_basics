defmodule HexletBasics.Notifications.EmailDeliveryStatusEnum do
  use EctoEnum, sent: "sent", bounce: "bounce", spam: "spam", rejected: "rejected", unsub: "unsub"
end
