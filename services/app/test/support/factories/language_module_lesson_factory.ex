defmodule HexletBasics.LanguageModuleLessonFactory do
  defmacro __using__(_opts) do
    quote do
      def language_module_lesson_factory do
        module = insert(:language_module)
        %HexletBasics.Language.Module.Lesson{
          slug: Faker.Internet.slug,
          order: 100,
          module: module,
          language: module.language,
          path_to_code: "/exercises/modules/10-basics/10-hello-world",
          descriptions: [
            build(:language_module_lesson_description),
            build(:language_module_lesson_description, locale: "en")
          ]
        }
      end
    end
  end
end
