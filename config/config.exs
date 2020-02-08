# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sjcchoops,
  namespace: SJCCHoops,
  ecto_repos: [SJCCHoops.Repo]

# Configures the endpoint
config :sjcchoops, SJCCHoopsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cyzbSaG0fPaHQFYBwqpqnF9bdeCUfvxDfexSc5WA4LzKTK8/lvRoN95jRakdg260",
  render_errors: [view: SJCCHoopsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SJCCHoops.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
