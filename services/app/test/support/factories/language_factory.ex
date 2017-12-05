defmodule HexletBasics.LanguageFactory do
  defmacro __using__(_opts) do
    quote do
      def language_factory do
        %HexletBasics.Language{
          slug: Faker.Internet.slug,
          name: Faker.Internet.slug,
          upload: build(:upload)
        }
      end
    end
  end
end
