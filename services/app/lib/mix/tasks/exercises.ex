defmodule Mix.Tasks.X.Exercises do
  use Mix.Task
  # import Mix.Ecto
  require Logger
  alias HexletBasics.Repo, as: Repo
  alias HexletBasics.Language, as: Language
  alias HexletBasics.Language.Module.Lesson, as: Lesson
  alias HexletBasics.Upload, as: Upload

  @shortdoc "Load exercises"
  def run([lang_name]) do
    Application.ensure_all_started(:hexlet_basics)

    dest = "/var/tmp/hexlet-basics-exercises-#{lang_name}"

    { :ok, upload } = Repo.insert(%Upload{
      language_name: lang_name
    })

    language = upsert_lang(upload, lang_name)

    up_repo(lang_name, dest)
    modulesWithMeta = get_modules(dest)
    modules = modulesWithMeta
    |> Enum.map(fn({ order, slug, descriptions }) ->
      upsert_module_with_descriptions(language, order, slug, descriptions)
    end)

    modules
    |> Enum.flat_map(fn(module) ->
      get_lessons(dest, module, language)
    end)
    |> Enum.map(&upsert_lesson_with_descriptions/1)
  end

  def get_lessons(dest, module, language) do
    module_path = Path.join(dest, "#{module.order}-#{module.slug}")
    wildcard_path = Path.join([module_path, "*"])
    Path.wildcard(wildcard_path)
    |> Enum.filter(&File.dir?/1)
    |> Enum.map(&Path.basename/1)
    |> Enum.map(fn(folder) ->
      [order, slug] = String.split(folder, "-", parts: 2)
      lesson_path = Path.join(module_path, folder)
      descriptions = get_descriptions(lesson_path)
      { :ok, test_code } = File.read(Path.join(lesson_path, "test.#{language.slug}"))
      { :ok, original_code } = File.read(Path.join(lesson_path, "index.#{language.slug}"))
      prepared_code = prepare_code(original_code)

      { language, module, order, slug, prepared_code, original_code, test_code, descriptions }
    end)
  end

  def upsert_lesson_with_descriptions({ language, module, order, slug, prepared_code, original_code, test_code, descriptions }) do
    module = case Repo.get_by(Lesson, module_id: module.id, slug: slug) do
      nil  -> %Lesson{ module_id: module.id, slug: slug }
      module -> module
    end
    module
    |> Lesson.changeset(%{
      language_id: language.id,
      order: order,
      upload_id: language.upload_id,
      original_code: original_code,
      prepared_code: prepared_code,
      test_code: test_code
    })
    |> Repo.insert_or_update!

    descriptions
    |> Enum.map(&(upsert_lesson_description(module, &1)))

    module
  end

  def upsert_lesson_description(module, { locale, data }) do
    case Repo.get_by(Lesson.Description, lesson_id: module.id, locale: locale) do
      nil  -> %Lesson.Description{ lesson_id: module.id, locale: locale }
      module -> module
    end
    |> Lesson.Description.changeset(data)
    |> Repo.insert_or_update!
  end


  def get_modules(dest) do
    Path.wildcard("#{dest}/*")
    |> Enum.filter(&File.dir?/1)
    |> Enum.map(&Path.basename/1)
    |> Enum.map(fn(folder) ->
      [order, slug] = String.split(folder, "-", parts: 2)
      descriptions = get_descriptions(Path.join(dest, folder))
      { order, slug, descriptions }
    end)
  end

  def get_descriptions(path) do
    Path.wildcard("#{path}/description.*.yml")
    |> Enum.map(fn(filepath) ->
      filename = Path.basename(filepath)
      [_, locale, _] = String.split(filename, ".")
      data = YamlElixir.read_from_file filepath
      { locale, data }
    end)
  end

  def upsert_module_with_descriptions(language, order, slug, descriptions) do
    module = case Repo.get_by(Language.Module, language_id: language.id, slug: slug) do
      nil  -> %Language.Module{ language_id: language.id, slug: slug }
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
    case Repo.get_by(Language.Module.Description, module_id: module.id, locale: locale) do
      nil  -> %Language.Module.Description{ module_id: module.id, locale: locale }
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
        Git.pull repo, ~w(--rebase)
        repo
      {:ok, repo} -> repo
    end
    Logger.debug inspect repo
  end

  def prepare_code(code) do
    code
  end
end
