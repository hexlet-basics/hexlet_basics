use Mix.Config


# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hexlet_basics, HexletBasicsWeb.Endpoint,
  http: [port: 4001],
  server: false

config :hexlet_basics,
  common: %{
    code_directory: "/tmp/hexlet-basics-test/code",
    langs: %{}
  },
  ru: %{
    ga: ""
  },
  en: %{
    ga: ""
  }

config :rollbax, enabled: false

# Print only warnings and errors during test
# config :logger, level: :warn
config :logger, :console, format: "[$level] $message\n"

# Configure your database
config :hexlet_basics, HexletBasics.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "hexlet_basics_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox
