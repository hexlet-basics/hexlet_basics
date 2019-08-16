defmodule HexletBasicsWeb.LessonControllerTest do
  use HexletBasicsWeb.ConnCase
  alias HexletBasics.{UserManager.Guardian}

  test "next not authorized user", %{conn: conn} do
    lesson = insert(:language_module_lesson)
    conn = get conn, lesson_member_path(conn, :next, lesson.id)
    assert html_response(conn, 302)
  end

  test "next", %{conn: conn} do
    user = insert(:user)
    lesson = insert(:language_module_lesson)
    next_lesson = insert(:language_module_lesson, %{language: lesson.language, module: lesson.module, natural_order: 110, upload: lesson.language.upload})

    conn = conn
           |> Guardian.Plug.sign_in(user)
           |>get(lesson_member_path(conn, :next, lesson.id))
    language = next_lesson.language
    module = next_lesson.module
    path =
      language_module_lesson_path(conn, :show, language.slug, module.slug, next_lesson.slug)

    assert redirected_to(conn) == path
  end

  test "next when not finished lesson exists", %{conn: conn} do
    not_finished_lesson = insert(:language_module_lesson)
    finished_lesson = insert(:language_module_lesson,
      %{language: not_finished_lesson.language,
        module: not_finished_lesson.module,
        upload: not_finished_lesson.language.upload
      })
    user = insert(:user)
    user_finished_lesson = insert(:user_finished_lesson, %{language_module_lesson: finished_lesson, user: user})

    conn =  conn
            |> Guardian.Plug.sign_in(user)
            |>get(lesson_member_path(conn, :next, finished_lesson.id))
    language = not_finished_lesson.language
    module = not_finished_lesson.module
    path =
      language_module_lesson_path(conn, :show, language.slug, module.slug, not_finished_lesson.slug)

    assert redirected_to(conn) == path
  end
end
