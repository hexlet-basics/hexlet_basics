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

      def will_removed_user_factory do
        %HexletBasics.User{
          email: "user@user.ru",
          github_uid: System.unique_integer([:monotonic, :positive]),
          facebook_uid: to_string(System.unique_integer([:monotonic, :positive])),
          nickname: Faker.Internet.slug,
          first_name: Faker.Name.En.first_name(),
          last_name: Faker.Name.En.first_name(),
          encrypted_password: Bcrypt.hash_pwd_salt("password"),
          reset_password_token: Bcrypt.hash_pwd_salt("reset_token"),
          confirmation_token: Bcrypt.hash_pwd_salt("confirmation_token"),
          state: "active"
        }
      end
    end
  end
end
