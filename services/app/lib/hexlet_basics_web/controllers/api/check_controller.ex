defmodule HexletBasicsWeb.Api.CheckController do
  use HexletBasicsWeb, :controller
  alias HexletBasics.Repo, as: Repo
  alias HexletBasics.Language, as: Language
  import Ecto.Query

  def create(conn, %{}) do
    # FIXME: return errros if timeout
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


