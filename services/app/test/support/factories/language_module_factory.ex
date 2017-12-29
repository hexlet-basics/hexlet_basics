defmodule HexletBasics.LanguageModuleFactory do
  defmacro __using__(_opts) do
    quote do
      def language_module_factory do
        language = insert(:language)
        %HexletBasics.Language.Module{
          slug: Faker.Internet.slug,
          language: language,
          upload: language.upload,
          order: 100,
          descriptions: [
            build(:language_module_description, language: language),
            build(:language_module_description, locale: "en", language: language)
          ]
        }
      end
    end
  end
end
