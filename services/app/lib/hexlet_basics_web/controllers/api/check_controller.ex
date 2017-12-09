defmodule HexletBasicsWeb.Api.CheckController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo, as: Repo
  alias HexletBasics.Language, as: Language
  import Ecto.Query

  def create(conn, _params) do
    # FIXME: return errros if timeout
    %{assigns: %{current_user: current_user}} = conn

    part = current_user.id
           |> Integer.to_string
           |> String.pad_leading(6, "0")
           |> String.reverse
           |> String.to_charlist
           |> Enum.chunk(3)
           |> Path.join

    prefix = Application.fetch_env!(:hexlet_basics, :code_directory)
    full_path = Path.join(prefix, part)
    # TODO use mocks. there is no fakefs library in elixir world (
    File.mkdir_p("/#{full_path}")

    json conn, %{
      type: "check",
      data: %{
        attributes: %{
          output: "lalala"
        }
      }
    }
  end
end


