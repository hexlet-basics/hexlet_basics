defmodule HexletBasics.LanguageModuleLessonFactory do
  defmacro __using__(_opts) do
    quote do
      def language_module_lesson_factory do
        module = insert(:language_module)
        language = module.language

        %HexletBasics.Language.Module.Lesson{
          slug: Faker.Internet.slug(),
          order: 100,
          natural_order: 100,
          module: module,
          language: language,
          upload: module.upload,
          path_to_code: "/exercises/modules/10-basics/10-hello-world",
          descriptions: [
            build(:language_module_lesson_description, language: language),
            build(:language_module_lesson_description, locale: "en", language: language)
          ]
        }
      end
    end
  end
end
