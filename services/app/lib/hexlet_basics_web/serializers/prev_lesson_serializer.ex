defmodule HexletBasicsWeb.Serializers.PrevLessonSerializer do
  use Remodel

  attributes([:id, :slug, :module])

  def module(record) do
    record.module
  end
end
