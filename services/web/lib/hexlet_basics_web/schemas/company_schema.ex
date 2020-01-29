defmodule HexletBasicsWeb.Schemas.CompanySchema do
  alias HexletBasicsWeb.Router.Helpers, as: Routes

  def build(conn) do
    %{
      "@context": "https://schema.org",
      "@type": "Organization",
      url: "http://hexlet.io",
      name: "Hexlet",
      legalName: "Hexlet Ltd.",
      vatID: "VAT ID: FI26641607",
      telephone: "+44 20 3514 2938",
      sameAs: [
        "https://www.facebook.com/Hexlet",
        "https://www.youtube.com/user/HexletUniversity",
        "https://twitter.com/HexletHQ",
        "https://soundcloud.com/hexlet"
      ],
      address: %{
        "@type": "PostalAddress",
        name: "Puolikkotie 8, 02230 Espoo, Finland"
      },
      logo: %{
        "@type": "ImageObject",
        url: Routes.static_url(conn, "/images/hexlet_logo.png")
      },
      email: %{
        "@type": "Text",
        "@id": "mailto:support@hexlet.io"
      }
    }
  end
end
