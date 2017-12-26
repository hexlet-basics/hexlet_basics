defmodule HexletBasics.Repo.Migrations.AddNaturalOrderToLesson do
  use Ecto.Migration

  def change do
    alter table(:language_module_lessons) do
      add :natural_order, :integer
    end
  end
end
