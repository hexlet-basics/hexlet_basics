defmodule HexletBasics.Repo do
  use Ecto.Repo,
    otp_app: :hexlet_basics,
    adapter: Ecto.Adapters.Postgres

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    if url = System.get_env("DATABASE_URL") do
      {:ok, Keyword.put(opts, :url, url)}
    else
      {:ok, opts}
    end
  end

  def get_assoc_by!(model, associationName, query) do
    get_by!(Ecto.assoc(model, associationName), query)
  end
end
