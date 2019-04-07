defmodule LiveviewTodoWeb.Users.Index do
  use Phoenix.LiveView

  alias LiveviewTodo.Accounts
  alias LiveviewTodoWeb.UserView

  def mount(_session, socket) do
    users = Accounts.list_users()

    {:ok, assign(socket, users: users)}
  end

  def render(assigns) do
    UserView.render("index.html", assigns)
  end
end
