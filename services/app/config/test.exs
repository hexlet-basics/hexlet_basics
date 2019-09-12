use Mix.Config


# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hexlet_basics, HexletBasicsWeb.Endpoint,
  secret_key_base: "secret-key-base-secret-key-base-secret-key-base-secret-key-basesecret-key-base-secret-key-base-secret-key-base-secret-key-basesecret-key-base-secret-key-base-secret-key-base-secret-key-base",
  http: [port: 4001],
  server: false

config :hexlet_basics,
  docker_command_template: "echo 'docker run --rm ~s ~s timeout -t 1 make --silent -C ~s test'",
  code_directory: "/tmp/hexlet-basics-test/code",
  langs: %{},
  ga: "gtag",
  gtm: "gtm"

config :rollbax, enabled: false

# Print only warnings and errors during test
config :logger, level: :warn
# config :logger, :console, format: "[$level] $message\n"

config :hexlet_basics, HexletBasics.UserManager.Guardian,
  issuer: "hexlet_basics",
  secret_key: "asdf"

# Configure your database
config :hexlet_basics, HexletBasics.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "hexlet_basics_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox
