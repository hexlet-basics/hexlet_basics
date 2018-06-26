defmodule HexletBasicsWeb.Api.Lesson.CheckController do
  require Logger
  use HexletBasicsWeb, :controller
  alias HexletBasics.{Repo, User}
  alias HexletBasics.Language.Module.Lesson
  # import Ecto.Query

  def create(conn, params) do
    # FIXME: return errros if timeout
    %{assigns: %{current_user: current_user}} = conn
    %{"data" => %{"attributes" => %{"code" => code}}, "lesson_id" => lesson_id} = params

    lesson = Repo.get(Lesson, lesson_id) |> Repo.preload(:language)
    language = lesson.language
    code_directory = Application.fetch_env!(:hexlet_basics, :code_directory)
    full_directory_path = Path.join(code_directory, User.directory_for_code(current_user))
    # TODO use mocks. there is no fakefs library in elixir world (
    File.mkdir_p(full_directory_path)
    Logger.debug ['mkdir_p ', full_directory_path]

    full_exercise_file_path = Path.join(full_directory_path, Lesson.file_name_for_exercise(lesson))
    File.write(full_exercise_file_path, code || '')
    Logger.debug ['write ', full_exercise_file_path]

    path_to_exersice_file = Path.join(lesson.path_to_code, language.exercise_filename)
    volume = "-v #{full_exercise_file_path}:#{path_to_exersice_file}"
    docker_command_template = Application.fetch_env!(:hexlet_basics, :docker_command_template)
    command = :io_lib.format(docker_command_template, [volume, language.docker_image, lesson.path_to_code])
    command = String.Chars.to_string(command)
    Logger.debug command
    %Porcelain.Result{out: output, status: status} = Porcelain.shell(command)
    Logger.debug output

    result = case status do
      0 -> "passed"
      124 -> "failed-infinity"
      _ -> "failed"
    end
    passed = result == "passed"
    if passed do
      may_be_user_finished_lesson = Repo.get_by(User.FinishedLesson, user_id: current_user.id, language_module_lesson_id: lesson.id)
      unless may_be_user_finished_lesson do
        %User.FinishedLesson{user_id: current_user.id, language_module_lesson_id: lesson.id} |> Repo.insert
      end
    end

    json conn, %{
      type: "check",
      data: %{
        attributes: %{
          passed: passed,
          result: result,
          status: status,
          output: output
        }
      }
    }
  end
end


