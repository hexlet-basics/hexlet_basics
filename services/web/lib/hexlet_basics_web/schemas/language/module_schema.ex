defmodule HexletBasicsWeb.Schemas.Language.ModuleSchema do
  alias HexletBasicsWeb.Schemas.CompanySchema
  alias HexletBasicsWeb.Router.Helpers, as: Routes

  def build(conn, module, module_description, language) do
    %{
      "@context": "https://schema.org",
      "@type": "Course",
      name: module_description.name,
      description: module_description.description,
      accessMode: "textOnVisual",
      isAccessibleForFree: "https://schema.org/True",
      url: Routes.language_module_lesson_path(conn, :index, language.slug, module.slug),
      provider: CompanySchema.build(conn)
    }
  end
end
