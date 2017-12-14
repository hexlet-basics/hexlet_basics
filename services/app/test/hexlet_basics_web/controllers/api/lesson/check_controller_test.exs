defmodule HexletBasicsWeb.Api.Lesson.CheckControllerTest do
  import Plug.Conn
  use HexletBasicsWeb.ConnCase

  @tag :skip
  test "create", %{conn: conn} do
    lesson = insert(:language_module_lesson)
    data = %{
      attributes: %{
        code: "<?php
        sleep(10);
        print_r('HELLOOO FROM PHP!!!');
        "
      }
    }
    user = insert(:user)
    conn = conn
           |> put_session(:current_user, user)
           |> post(lesson_check_path(conn, :create, lesson.id), data: data)

    assert json_response(conn, 200)
  end
end
