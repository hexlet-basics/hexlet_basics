defmodule Mix.Tasks.X.Exercises do
  use Mix.Task
  import Mix.Ecto
  require Logger
  alias HexletBasics.Repo, as: Repo
  alias HexletBasics.Language, as: Language
  alias HexletBasics.Upload, as: Upload

  @shortdoc "Load exercises"
  def run([lang_name]) do
    ensure_started(Repo, [])

    dest = "/var/tmp/hexlet-basics-exercises-#{lang_name}"

    { :ok, upload } = Repo.insert(%Upload{
      language_name: lang_name
    })

    language = upsert_lang(upload, lang_name)

    up_repo(lang_name, dest)
    modulesWithMeta = get_modules(dest)
    modulesWithMeta
    |> Enum.map(fn({ order, module_name, descriptions }) ->
      upsert_module_with_descriptions(language, order, module_name, descriptions)
    end)

    # IO.puts inspect folders
  end

  def get_modules(dest) do
    Path.wildcard("#{dest}/*")
    |> Enum.filter(&File.dir?/1)
    |> Enum.map(&Path.basename/1)
    |> Enum.map(fn(folder) ->
      [order, module_name] = String.split(folder, "-", parts: 2)
      descriptions = get_module_descriptions(Path.join(dest, folder))
      { order, module_name, descriptions }
    end)
  end

  def get_module_descriptions(module_path) do
    Path.wildcard("#{module_path}/description.*.yml")
    # |> YAML
    []
  end

  def upsert_module_with_descriptions(language, order, module_name, descriptions) do
    module = case Repo.get_by(Language.Module, language_id: language.id, slug: module_name) do
      nil  -> %Language.Module{ language_id: language.id, slug: module_name }
      module -> module
    end
    module
    |> Language.Module.changeset(%{ order: order, upload_id: language.upload_id })
    |> Repo.insert_or_update!

    descriptions
    |> Enum.map(&(upsert_module_description(module, &1)))

    module
  end

  def upsert_module_description(module, { locale, data }) do
    case Repo.get_by(Language.Module.Description, language_module_id: module.id, locale: locale) do
      nil  -> %Language.Module.Description{ language_module_id: module.id, locale: locale }
      module -> module
    end
    |> Language.Module.Description.changeset(data)
    |> Repo.insert_or_update!
  end

  def upsert_lang(upload, lang_name) do
    language = case Repo.get_by(Language, slug: lang_name) do
      nil  -> %Language{ slug: lang_name }
      lang -> lang
    end
    language
    |> Language.changeset(%{ upload_id: upload.id, name: lang_name })
    |> Repo.insert_or_update!

    language
  end

  def up_repo(lang_name, dest) do
    url = "https://github.com/hexlet-basics/exercises-#{lang_name}"
    Logger.debug dest
    repo = case Git.clone [url, dest] do
      {:error, _} ->
        repo = Git.new dest
        Git.pull repo, ~w(--rebase upstream master)
        repo
      {:ok, repo} -> repo
    end
    Logger.debug inspect repo
  end
end
