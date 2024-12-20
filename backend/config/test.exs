import Config

config :backend, Backend.Repo,
  username: "postgres",
  password: "postgres",
  database: "backend_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
