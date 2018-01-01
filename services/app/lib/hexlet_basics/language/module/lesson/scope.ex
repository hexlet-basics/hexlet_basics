defmodule HexletBasics.Language.Module.Lesson.Scope do
  import Ecto.Query

  def web(query, language, locale) do
    query
    |> for_upload(language.upload_id)
    |> for_locale(locale)
    |> order_by([l], [asc: l.natural_order])
  end

  def for_locale(query, locale) do
    from m in query,
      join: d in assoc(m, :descriptions),
      where: d.locale == ^locale
  end

  def for_upload(query, upload_id) do
    from l in query,
      where: l.upload_id == ^upload_id
  end
end
