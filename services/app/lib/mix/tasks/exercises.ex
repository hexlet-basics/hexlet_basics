defmodule Mix.Tasks.X.Exercises.Load do
  use Mix.Task
  # import Mix.Ecto
  require Logger
  alias HexletBasics.Repo
  alias HexletBasics.Language
  alias HexletBasics.Language.Module
  alias HexletBasics.Language.Module.Lesson
  alias HexletBasics.Upload

  @shortdoc "Load exercises"
  def run([lang_name]) do
    Application.ensure_all_started(:hexlet_basics)

    repo_dest = "/exercises-#{lang_name}"
    module_dest = "#{repo_dest}/modules"

    {:ok, upload} =
      Repo.insert(%Upload{
        language_name: lang_name
      })

    # up_repo(lang_name, repo_dest)
    {:ok, language} = upsert_language(upload, lang_name, repo_dest)

    modules_with_meta = get_modules(module_dest)

    modules =
      modules_with_meta
      |> Enum.map(fn data ->
        upsert_module_with_descriptions(language, data)
      end)

    # TODO: remove old modules

    modules
    |> Enum.flat_map(fn module ->
      get_lessons(module_dest, module, language)
    end)
    |> Enum.with_index()
    |> Enum.each(&upsert_lesson_with_descriptions/1)

    # TODO: remove old lessons
  end

  def get_lessons(dest, module, language) do
    module_directory = Module.get_directory(module)
    module_path = Path.join(dest, module_directory)
    wildcard_path = Path.join(module_path, "*")
    files = Path.wildcard(wildcard_path)

    files
    |> Enum.filter(&File.dir?/1)
    |> Enum.map(&Path.basename/1)
    |> Enum.map(fn directory ->
      [order, slug] = String.split(directory, "-", parts: 2)
      lesson_path = Path.join(module_path, directory)
      descriptions = get_descriptions(lesson_path)
      # TODO: extract to lang spec
      test_file_path = Path.join(lesson_path, language.exercise_test_filename)
      Logger.debug(test_file_path)
      {:ok, test_code} = File.read(test_file_path)
      {:ok, original_code} = File.read(Path.join(lesson_path, language.exercise_filename))
      prepared_code = prepare_code(original_code)

      path_to_code =
        Path.join(["/exercises-#{language.slug}/modules", module_directory, directory])

      {language, module, order, slug, prepared_code, original_code, test_code, descriptions,
       path_to_code}
    end)
  end

  def upsert_lesson_with_descriptions(
        {{language, module, order, slug, prepared_code, original_code, test_code, descriptions,
          path_to_code}, i}
      ) do
    may_be_lesson =
      Repo.get_by(Lesson, language_id: language.id, module_id: module.id, slug: slug)

    lesson =
      case may_be_lesson do
        nil -> %Lesson{language_id: language.id, module_id: module.id, slug: slug}
        entity -> entity
      end

    lesson =
      lesson
      |> Lesson.changeset(%{
        order: order,
        natural_order: i + 1,
        path_to_code: path_to_code,
        upload_id: language.upload_id,
        original_code: original_code,
        prepared_code: prepared_code,
        module_id: module.id,
        test_code: test_code
      })
      |> Repo.insert_or_update!()

    if Enum.empty?(descriptions) do
      raise "Lesson '#{module.slug}.#{lesson.slug}' does not have descriptions"
    end

    descriptions
    |> Enum.each(&upsert_lesson_description(lesson, &1))

    lesson
  end

  def upsert_lesson_description(lesson, {locale, data}) do
    description =
      case Repo.get_by(Lesson.Description, lesson_id: lesson.id, locale: locale) do
        nil -> %Lesson.Description{lesson_id: lesson.id, locale: locale}
        module -> module
      end

    new_data =
      Map.merge(data, %{
        "language_id" => lesson.language_id
      })

    Logger.debug(inspect(new_data))

    description
    |> Lesson.Description.changeset(new_data)
    |> Repo.insert_or_update!()
  end

  def get_modules(dest) do
    files = Path.wildcard("#{dest}/*")

    files
    |> Enum.filter(&File.dir?/1)
    |> Enum.map(&Path.basename/1)
    |> Enum.map(fn directory ->
      [order, slug] = String.split(directory, "-", parts: 2)
      Logger.debug("parsed module: #{slug}")
      descriptions = get_descriptions(Path.join(dest, directory))
      %{order: order, slug: slug, descriptions: descriptions}
    end)
  end

  def get_descriptions(path) do
    files = Path.wildcard("#{path}/description.*.yml")

    files
    |> Enum.map(fn filepath ->
      filename = Path.basename(filepath)
      [_, locale, _] = String.split(filename, ".")
      Logger.debug(filepath)
      {:ok, data} = YamlElixir.read_from_file(filepath)
      {locale, data}
    end)
  end

  def upsert_module_with_descriptions(language, data) do
    %{order: order, slug: slug, descriptions: descriptions} = data

    maybe_module = Repo.get_by(Language.Module, language_id: language.id, slug: slug)

    module =
      case maybe_module do
        nil -> %Language.Module{language_id: language.id, slug: slug}
        module -> module
      end

    {:ok, _} = module
      |> Language.Module.changeset(%{
        order: order,
        upload_id: language.upload_id
      })
      |> Repo.insert_or_update()

    if Enum.empty?(descriptions) do
      raise "Module '#{module.slug}' does not have descriptions"
    end

    descriptions
    |> Enum.each(&upsert_module_description(module, &1))

    module
  end

  def upsert_module_description(module, {locale, data}) do
    description =
      case Repo.get_by(Language.Module.Description, module_id: module.id, locale: locale) do
        nil -> %Language.Module.Description{module_id: module.id, locale: locale}
        module -> module
      end

    {:ok, _} = description
    |> Language.Module.Description.changeset(
      Map.merge(data, %{"language_id" => module.language_id})
    )
    |> Repo.insert_or_update()
  end

  def upsert_language(upload, lang_name, repo_dest) do
    spec_filepath = Path.join(repo_dest, "spec.yml")
    {:ok, %{"language" => language_info}} = YamlElixir.read_from_file(spec_filepath)

    language =
      case Repo.get_by(Language, slug: lang_name) do
        nil -> %Language{slug: lang_name}
        entity -> entity
      end

    language
    |> Language.changeset(%{
      upload_id: upload.id,
      name: lang_name,
      docker_image: language_info["docker_image"],
      extension: language_info["extension"],
      exercise_filename: language_info["exercise_filename"],
      exercise_test_filename: language_info["exercise_test_filename"]
    })
    |> Repo.insert_or_update()
  end

  def up_repo(lang_name, dest) do
    url = "https://github.com/hexlet-basics/exercises-#{lang_name}"
    Logger.debug(dest)

    repo =
      case Git.clone([url, dest]) do
        {:error, _} ->
          repo = Git.new(dest)
          Git.pull(repo, ~w(--rebase))
          repo

        {:ok, repo} ->
          repo
      end

    Logger.debug(inspect(repo))
  end

  def prepare_code(code) do
    reg = ~r/(?<begin>^[^\n]*?BEGIN.*?$\s*)(?<content>.+?)(?<end>^[^\n]*?END.*?$)/msu
    result = Regex.replace(reg, code, "\\1\n\\3")

    if result != code do
      result
    else
      ""
    end
  end
end
