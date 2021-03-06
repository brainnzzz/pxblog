use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pxblog, PxblogWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :pxblog, Pxblog.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "pxblog",
  password: "secret",
  database: "pxblog_test",
  hostname: "database",
  pool: Ecto.Adapters.SQL.Sandbox

config :comeonin , bcrupt_log_rounds: 4
