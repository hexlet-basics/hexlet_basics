defmodule HexletBasics.UserAccountFactory do
  defmacro __using__(_opts) do
    quote do
      def user_account_factory do
        user = insert(:user)

        %HexletBasics.User.Account{
          uid: to_string(System.unique_integer([:monotonic, :positive])),
          provider: "github",
          user: user
        }
      end
    end
  end
end
