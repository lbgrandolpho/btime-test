import Config

config :backend,
  ecto_repos: [Backend.Repo]

config :backend, BackendWeb.Endpoint,
  url: [host: "localhost"],
  http: [
    ip: {0, 0, 0, 0},
    port: 4000
  ],
  secret_key_base: "shh it's a secret",
  pubsub_server: Backend.PubSub

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
