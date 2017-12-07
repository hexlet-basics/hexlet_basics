defmodule HexletBasics.LanguageModuleLessonFactory do
  defmacro __using__(_opts) do
    quote do
      def language_module_lesson_factory do
        module = insert(:language_module)
        %HexletBasics.Language.Module.Lesson{
          slug: Faker.Internet.slug,
          order: 100,
          module: module,
          language: module.language
        }
      end
    end
  end
end
