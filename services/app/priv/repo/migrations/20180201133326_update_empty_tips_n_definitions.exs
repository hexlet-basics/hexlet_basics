defmodule HexletBasics.Repo.Migrations.UpdateEmptyTipsNDefinitions do
  use Ecto.Migration
  import Ecto.Query
  alias HexletBasics.Repo
  alias HexletBasics.Language.Module.Lesson.Description

  def change do
    from(d in Description, where: is_nil(d.tips))
    |> (&Repo.update_all(&1, set: [tips: []])).()

    from(d in Description, where: is_nil(d.definitions))
    |> (&Repo.update_all(&1, set: [definitions: []])).()
  end
end
