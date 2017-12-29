defmodule HexletBasics.Language.Module.Scope do
  import Ecto.Query

  def web(query, language) do
    scope = for_upload(query, language.upload_id)
    scope |> order_by([m], [asc: m.order])
  end

  def for_upload(query, upload_id) do
    from m in query,
      where: m.upload_id == ^upload_id
  end
end
