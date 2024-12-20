import Config

config :backend, Backend.Repo,
  database: "backend_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
