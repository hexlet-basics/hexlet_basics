defmodule HexletBasics.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hexlet_basics,
      version: "0.0.1",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers, # ++ [:jsroutes],
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {HexletBasics.Application, []},
      extra_applications: [
        :logger,
        :runtime_tools,
        :yaml_elixir,
        # :rollbax,
        :ueberauth_github,
        :ueberauth,
        :porcelain
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},

      # {:distillery, "~> 1.5", runtime: false},
      {:phoenix_slime, github: "slime-lang/phoenix_slime"},
      {:ecto_state_machine, "~> 0.1.0"},
      {:phoenix_jsroutes, "~> 0.0.4"},
      {:ex_machina, github: "thoughtbot/ex_machina", only: :test},
      {:earmark, github: "pragdave/earmark"},
      {:faker, "~> 0.9", only: :test},
      {:yaml_elixir, "~> 1.3.1"},
      {:rollbax, github: "elixir-addicts/rollbax"},
      {:phoenix_gon, github: "khusnetdinov/phoenix_gon"},
      # {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:git_cli, "~> 0.2"},
      {:porcelain, "~> 2.0"},
      {:ueberauth_github, "~> 0.6"},
      {:ueberauth, "~> 0.4"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
      "compile": ["compile --warnings-as-errors"]
    ]
  end
end
