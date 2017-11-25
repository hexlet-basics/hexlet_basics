defmodule Mix.Tasks.X.Exercises do
  use Mix.Task

  @shortdoc "Load exercises"
  def run(_) do
    url = "https://github.com/hexlet-basics/exercises-php"
    dest = "/var/tmp/hexlet-basics-exercises-php"
    repo = case Git.clone [url, dest] do
      {:error, _} ->
        repo = Git.new dest
        Git.pull repo, ~w(--rebase upstream master)
        repo
      {:ok, repo} -> repo
    end
    IO.puts inspect repo

    folders = Path.wildcard("#{dest}/*")
      |> Enum.filter(&(File.dir? &1))

    IO.puts inspect folders
  end
end
