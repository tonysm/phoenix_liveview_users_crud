defmodule LiveviewTodo.Repo do
  use Ecto.Repo,
    otp_app: :liveview_todo,
    adapter: Ecto.Adapters.Postgres
end
