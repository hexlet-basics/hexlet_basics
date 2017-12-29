defmodule HexletBasics.Language.Module.Lesson.Scope do
  import Ecto.Query

  def web(query, language) do
    scope = for_upload(query, language.upload_id)
    scope |> order_by([l], [asc: l.natural_order])
  end

  def for_upload(query, upload_id) do
    from l in query,
      where: l.upload_id == ^upload_id
  end
end
