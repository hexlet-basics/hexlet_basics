defmodule HexletBasics.User.Scope do
  import Ecto.Query

  def web(query) do
    query
    |> active
  end

  def active(query) do
    from q in query, where: q.state == "active"
  end

  def not_removed(query) do
    from q in query, where: q.state != "removed"
  end
end
