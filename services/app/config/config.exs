# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :porcelain, :driver, Porcelain.Driver.Basic

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "read:user,user:email"]}
  ]

config :rollbax,
  access_token: System.get_env("ROLLBAR_ACCESS_TOKEN"),
  environment: "production"
  # enabled: true

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID_RU"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET_RU")

# General application configuration
config :hexlet_basics,
  docker_command_template: "docker run --rm ~s ~s timeout -t 1 make --silent -C ~s test",
  ecto_repos: [HexletBasics.Repo],
  disqus_ru: "hexlet-basics",
  disqus_en: "hexlet-basics-en"


config :hexlet_basics, HexletBasics.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  database: System.get_env("DB_NAME"),
  hostname: System.get_env("DB_HOSTNAME"),
  pool_size: 15

# config :playfair, Playfair.Gettext, default_locale: "ru_RU"

# Configures the endpoint
config :hexlet_basics, HexletBasicsWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: HexletBasicsWeb.ErrorView, accepts: ~w(html json)],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  pubsub: [name: HexletBasics.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
