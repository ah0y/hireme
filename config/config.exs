# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :storex,
  ecto_repos: [Storex.Repo]

# Configures the endpoint
config :storex, StorexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2e8Z0eEQCpOfrHX1Fl/ST/+pgEO0Y+6hOFLinhI9zwvx3d1jT9COtXA0rxjOm2lP",
  render_errors: [view: StorexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Storex.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure :ex_aws

config :ex_aws,
       access_key_id: [System.get_env("AWS_ACCESS_KEY_ID"), :owner],
       secret_access_key: [System.get_env("AWS_SECRET_ACCESS_KEY"), :owner],
       s3: [
         scheme: "https://",
         host: "s3-video-uploads.s3.amazonaws.com",
         region: "us-east-2"
       ]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
