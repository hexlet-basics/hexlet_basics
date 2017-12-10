defmodule Mixfile do
  use Mix.Project

  def project do
    [
      app: :hexlet_basics,
      deps: deps()
    ]
  end
  defp deps do
    [
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
    ]
  end
end
