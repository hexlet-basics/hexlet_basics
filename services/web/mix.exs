defmodule HexletBasics.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hexlet_basics,
      version: "0.0.1",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      # ++ [:jsroutes],
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
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
        :ueberauth_facebook,
        :ueberauth,
        :porcelain,
        :bamboo,
        :bamboo_smtp
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.0"},
      {:remodel, "~> 0.0.4"},
      {:phoenix_pubsub, "~> 1.0"},
      {:ecto_sql, "~> 3.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:postgrex, "~> 0.15.3"},
      {:jason, "~> 1.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:plug_cowboy, "~> 2.0"},
      {:phoenix_slime, "~> 0.13"},
      {:ecto_state_machine, "~> 0.3.0"},
      {:phoenix_jsroutes, "~> 0.0.4"},
      {:ex_machina, github: "thoughtbot/ex_machina", only: :test},
      {:earmark, "~> 1.4.3"},
      {:faker, "~> 0.9", only: :test},
      {:yaml_elixir, "~> 2.1.0"},
      {:rollbax, ">= 0.0.0"},
      {:phoenix_gon, github: "khusnetdinov/phoenix_gon"},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.3", only: [:dev], runtime: false},
      {:git_cli, "~> 0.2"},
      {:porcelain, "~> 2.0"},
      {:ueberauth_github, "~> 0.6"},
      {:ueberauth_facebook, "~> 0.8"},
      {:ueberauth, "~> 0.4"},
      {:bcrypt_elixir, "~> 2.0"},
      {:formulator, "~> 0.1.8"},
      {:bamboo, "~> 1.3"},
      {:bamboo_smtp, "~> 1.7.0"},
      {:hackney, github: "benoitc/hackney", override: true},
      {:machinery, "~> 1.0.0"},
      {:guardian, "~> 1.2"},
      {:cowboy, "~> 2.5"},
      {:html_sanitize_ex, "~> 1.3.0-rc3"}
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
      "ecto.setup": [
        "ecto.create",
        "ecto.load --skip-if-loaded",
        "run priv/repo/seeds.exs"
      ],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "db.migrate": ["ecto.migrate", "ecto.dump"],
      "db.rollback": ["ecto.rollback", "ecto.dump"],
      test: [
        "ecto.setup --quite",
        "ecto.load --skip-if-loaded",
        "test"
      ],
      # compile: ["compile --warnings-as-errors"]
    ]
  end
end
