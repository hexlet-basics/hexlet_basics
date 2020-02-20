defmodule Mixfile do
  use Mix.Project

  def project do
    [
      app: :hexlet_basics,
      version: "0.0.1",
      elixir: "~> 1.7",
      deps: deps(),
      dialyzer: [paths: ["services/app/_build/dev"]]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.2.2", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false}
    ]
  end
end
