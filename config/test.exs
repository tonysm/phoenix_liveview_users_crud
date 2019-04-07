use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :liveview_todo, LiveviewTodoWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :liveview_todo, LiveviewTodo.Repo,
  username: "postgres",
  password: "secret",
  database: "liveview_todo_test",
  hostname: "127.0.0.1",
  pool: Ecto.Adapters.SQL.Sandbox
