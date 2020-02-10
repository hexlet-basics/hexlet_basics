defmodule HexletBasics.UserManager.Guardian do
  use Guardian, otp_app: :hexlet_basics

  alias HexletBasics.UserManager

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case UserManager.get_user!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end
