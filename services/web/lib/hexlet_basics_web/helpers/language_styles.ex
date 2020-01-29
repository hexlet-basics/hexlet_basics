defmodule HexletBasicsWeb.Helpers.LanguageStyles do
  @mapping %{
    php: %{
      bg: "bg-blue",
    },
    javascript: %{
      bg: "bg-yellow",
    },
    java: %{
      bg: "bg-azure",
    },
    python: %{
      bg: "bg-orange",
    },
    html: %{
      bg: "bg-orange",
    },
    css: %{
      bg: "bg-azure",
    },
    racket: %{
      bg: "bg-red",
    },
    ruby: %{
      bg: "bg-red",
    },
    elixir: %{
      bg: "bg-indigo",
    },
    go: %{
      bg: "bg-cyan",
    },
  }

  def style_for_lang(lang, style) do
    @mapping[lang][style]
  end
end
