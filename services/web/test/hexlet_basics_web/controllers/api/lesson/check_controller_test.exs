defmodule HexletBasicsWeb.Api.Lesson.CheckControllerTest do
  import Plug.Conn
  use HexletBasicsWeb.ConnCase
  alias HexletBasics.UserManager.Guardian

  test "create", %{conn: conn} do
    lesson = insert(:language_module_lesson)
    data = %{
      attributes: %{
        code: %{ content: "<?php
        sleep(10);
        print_r('HELLOOO FROM PHP!!!');
        "
        }
      }
    }
    user = insert(:user)
    conn = conn
           |> Guardian.Plug.sign_in(user)
           |> post(lesson_check_path(conn, :create, lesson.id), data: data)

    assert json_response(conn, 200)
  end
end
