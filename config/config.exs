# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phrampu,
  ecto_repos: [Phrampu.Repo]

# Configures the endpoint
config :phrampu, Phrampu.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fHv0m2un0ms0Q3byIZ751UvvHS71CahwBbQktEAKC5JkcuJb1QOY/Jfar1EJYr7d",
  render_errors: [view: Phrampu.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Phrampu.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
