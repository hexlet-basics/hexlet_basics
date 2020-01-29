defmodule HexletBasicsWeb.Schemas.Language.Module.LessonSchema do
  alias HexletBasicsWeb.Schemas.CompanySchema
  alias HexletBasicsWeb.Router.Helpers, as: Routes

  def build(conn, lesson, lesson_description, lesson_theory_html) do
    %{
      "@context": "https://schema.org",
      "@type": "TechArticle",
      author: Gettext.gettext(HexletBasicsWeb.Gettext, "Code Basics Author"),
      headline: lesson_description.name,
      datePublished: lesson.inserted_at,
      dateModified: lesson.updated_at,
      image: Routes.static_url(conn, "/images/smm_cover.jpg"),
      accessMode: "textOnVisual",
      publisher: CompanySchema.build(conn),
      hasPart: %{
        "@context": "https://schema.org",
        "@type": "WebPageElement",
        isAccessibleForFree: "https://schema.org/True",
        value: HtmlSanitizeEx.strip_tags(lesson_theory_html)
      }
    }
  end
end
