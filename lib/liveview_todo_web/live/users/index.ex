defmodule LiveviewTodoWeb.Users.Index do
  use Phoenix.LiveView

  alias LiveviewTodo.Accounts
  alias LiveviewTodoWeb.UserView
  alias LiveviewTodoWeb.Router.Helpers, as: Routes

  def mount(_session, socket) do
    users = Accounts.list_users()

    {:ok, assign(socket, users: users, editable_id: nil)}
  end

  def render(assigns) do
    UserView.render("index.html", assigns)
  end

  def handle_event("edit" <> user_id, _, socket) do
    user_id = String.to_integer(user_id)
    changeset = socket.assigns.users
                |> Enum.find(&(&1.id == user_id))
                |> Accounts.change_user()
                |> Map.put(:action, :update)

    {:noreply, assign(socket, editable_id: user_id, changeset: changeset)}
  end

  def handle_event("save", %{"id" => user_id, "user" => user_params}, socket) do
    user_id = String.to_integer(user_id)
    user = socket.assigns.users |> Enum.find(&(&1.id == user_id))

    case Accounts.update_user(user, user_params) do
      {:ok, _user} ->
        {:stop,
          socket
          |> put_flash(:info, "User was updated!")
          |> redirect(to: Routes.user_path(socket, :index))
        }
      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
