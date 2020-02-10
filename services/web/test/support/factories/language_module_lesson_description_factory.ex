defmodule HexletBasics.LanguageModuleLessonDescriptionFactory do
  defmacro __using__(_opts) do
    quote do
      def language_module_lesson_description_factory do
        %HexletBasics.Language.Module.Lesson.Description{
          # lesson: build(:lesson),
          theory: Faker.Lorem.paragraph,
          instructions: Faker.Lorem.paragraph,
          locale: "ru"
        }
      end
    end
  end
end
