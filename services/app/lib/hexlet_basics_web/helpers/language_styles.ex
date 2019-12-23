defmodule HexletBasicsWeb.Helpers.LanguageStyles do
  @mapping %{
    php: %{
      bg: "bg-indigo-dark",
    },
    javascript: %{
      bg: "bg-green-dark",
    },
    java: %{
      bg: "bg-red-dark",
    },
    python: %{
      bg: "bg-yellow",
    },
    html: %{
      bg: "bg-orange",
    },
    css: %{
      bg: "bg-blue",
    },
    racket: %{
      bg: "bg-blue-dark",
    },
    ruby: %{
      bg: "bg-red-dark",
    },
    elixir: %{
      bg: "bg-indigo-dark",
    },
    go: %{
      bg: "bg-cyan",
    },
  }

  def style_for_lang(lang, style) do
    @mapping[lang][style]
  end
end

