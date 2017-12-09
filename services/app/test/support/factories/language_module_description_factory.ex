defmodule HexletBasics.LanguageModuleDescriptionFactory do
  defmacro __using__(_opts) do
    quote do
      def language_module_description_factory do
        %HexletBasics.Language.Module.Description{
          # module: build(:language_module),
          name: Faker.Lorem.word,
          description: Faker.Lorem.paragraph,
          locale: "ru"
        }
      end
    end
  end
end
