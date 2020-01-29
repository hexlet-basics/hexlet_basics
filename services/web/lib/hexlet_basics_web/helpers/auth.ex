defmodule HexletBasicsWeb.Helpers.Auth do
  def signed_in?(conn) do
    current_user = conn.assigns[:current_user]
    !current_user.guest
  end
end
