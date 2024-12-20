import Config

config :backend, Backend.Repo,
  username: "postgres",
  password: "postgres",
  database: "backend_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox
