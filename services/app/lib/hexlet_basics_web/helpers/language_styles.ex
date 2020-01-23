defmodule HexletBasicsWeb.Helpers.LanguageStyles do
  @mapping %{
    php: %{
      bg: "bg-blue",
    },
    javascript: %{
      bg: "bg-indigo",
    },
    java: %{
      bg: "bg-azure",
    },
    python: %{
      bg: "bg-purple",
    },
    html: %{
      bg: "bg-green",
    },
    css: %{
      bg: "bg-yellow",
    },
    racket: %{
      bg: "bg-orange",
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
