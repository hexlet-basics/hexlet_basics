defmodule HexletBasics.Factory do
  use ExMachina.Ecto, repo: HexletBasics.Repo
  use HexletBasics.LanguageFactory
  use HexletBasics.UploadFactory
  use HexletBasics.LanguageModuleFactory
  use HexletBasics.LanguageModuleLessonFactory
end
