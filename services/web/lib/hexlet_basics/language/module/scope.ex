defmodule HexletBasics.Language.Module.Scope do
  import Ecto.Query

  def web(query, language, locale) do
    query
    |> for_upload(language.upload_id)
    |> for_locale(locale)
    |> order_by([m], [asc: m.order])
  end

  def for_locale(query, locale) do
    from m in query,
      join: d in assoc(m, :descriptions),
      where: d.locale == ^locale
  end

  def for_upload(query, upload_id) do
    from m in query,
      where: m.upload_id == ^upload_id
  end
end
