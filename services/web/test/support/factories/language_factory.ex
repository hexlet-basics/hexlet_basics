defmodule HexletBasics.LanguageFactory do
  defmacro __using__(_opts) do
    quote do
      def language_factory do
        %HexletBasics.Language{
          slug: Faker.Internet.slug,
          name: Faker.Internet.slug,
          upload: build(:upload),
          docker_image: "hexlet/hexlet-basics-exercises-php",
          extension: "php",
          exercise_filename: "index.php",
          exercise_test_filename: "Test.php"
        }
      end
    end
  end
end
