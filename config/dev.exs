use Mix.Config

config :message_system, MessageSystem.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "message_system",
  username: "ms_dev",
  password: "ms_dev_password",
  hostname: "localhost"

