# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hexlet_basics,
  ecto_repos: [HexletBasics.Repo]

# Configures the endpoint
config :hexlet_basics, HexletBasicsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KQk3Tlu9OZ10P+G4UD75S3RBfIoEXN8QNAiVh7IOvz43roP9bLux6C8cPMFEKlRx",
  render_errors: [view: HexletBasicsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HexletBasics.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
