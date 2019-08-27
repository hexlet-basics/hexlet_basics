defmodule HexletBasics.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %HexletBasics.User{
          github_uid: System.unique_integer([:monotonic, :positive]),
          nickname: Faker.Internet.slug,
          state: "active"
        }
      end
    end
  end
end
