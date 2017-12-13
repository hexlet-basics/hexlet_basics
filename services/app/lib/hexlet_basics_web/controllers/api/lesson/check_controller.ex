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
    prefix = Application.fetch_env!(:hexlet_basics, :code_directory)
    full_directory_path = Path.join(prefix, User.directory_for_code(current_user))
    # TODO use mocks. there is no fakefs library in elixir world (
    File.mkdir_p(full_directory_path)

    full_exercise_file_path = Path.join(full_directory_path, Lesson.file_name_for_exercise(lesson))
    File.write(full_exercise_file_path, code)

    path_to_exersice_file = Path.join(lesson.path_to_code, language.exercise_filename)
    volume = "-v #{full_exercise_file_path}:#{path_to_exersice_file}"
    command = "docker run --rm #{volume} #{language.docker_image} timeout -t 1 make --silent -C #{lesson.path_to_code} test"
    Logger.debug command
    %Porcelain.Result{out: output, status: status} = Porcelain.shell(command)

    json conn, %{
      type: "check",
      data: %{
        attributes: %{
          status: status,
          output: output
        }
      }
    }
  end
end


