# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chankins,
  ecto_repos: [Chankins.Repo]

# Configures the endpoint
config :chankins, Chankins.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CESyBbcDY8uqgb8+Uag9U+6cy9NP3rn9FtGpLFBMJDLllUOObwITOSe/L1db6snQ",
  render_errors: [view: Chankins.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chankins.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
