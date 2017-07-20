use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :phrampu, Phrampu.Endpoint,
  secret_key_base: "o1jmp7d8CrJAP7DUEViyerKKK+ECnC4Xxgm+pFhP61TsK+r6Juy020Nd/hRUJFP6"

# Configure your database
config :phrampu, Phrampu.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "phrampu_prod",
  pool_size: 20
