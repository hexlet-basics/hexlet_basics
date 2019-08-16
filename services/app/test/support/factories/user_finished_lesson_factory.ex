defmodule HexletBasics.UserFinishedLessonFactory do
  defmacro __using__(_opts) do
    quote do
      def user_finished_lesson_factory do
        user = insert(:user)
        lesson = insert(:language_module_lesson)

        %HexletBasics.User.FinishedLesson{
          user: user,
          language_module_lesson: lesson
        }
      end
    end
  end
end
