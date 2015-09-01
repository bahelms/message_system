use Mix.Config

config :message_system, MessageSystem.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "message_system_test",
  username: "ms_test",
  password: "ms_test_password",
  hostname: "localhost"

config :logger, :console, level: :info

