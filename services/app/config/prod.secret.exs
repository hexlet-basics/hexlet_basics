use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :hexlet_basics, HexletBasicsWeb.Endpoint,
  secret_key_base: "g5bhGGJIJL33c2l1dPmW8DR4Yn9yUnZ5F93BkwbmcrVvsuLv7PCdrt9guusigF1t"

# Configure your database
config :hexlet_basics, HexletBasics.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "hexlet_basics_prod",
  pool_size: 15
