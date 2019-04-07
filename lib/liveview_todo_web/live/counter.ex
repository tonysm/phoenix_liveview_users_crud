defmodule LiveviewTodoWeb.Counter do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div class="">
      <div>
        <button phx-click="increment">Increment</button>
        <%= @count %>
      <button phx-click="decrement">Decrement</button>
      </div>

      <div>
        <button phx-click="reverse">Reverse</button>
      </div>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    socket = socket
    |> assign(:count, 0)
    |> assign(:auto_direction, "inc")

    {:ok, socket}
  end

  def handle_info(:tick, socket) do
    case socket.assigns[:auto_direction] do
      "inc" ->
        {:noreply, update(socket, :count, &(&1 + 10))}
      "dec" ->
        {:noreply, update(socket, :count, &(&1 - 10))}
    end
  end

  def handle_event("increment", _value, socket) do
    {:noreply, update(socket, :count, &(&1 + 10))}
  end

  def handle_event("decrement", _value, socket) do
    {:noreply, update(socket, :count, &(&1 - 10))}
  end

  def handle_event("reverse", _value, socket) do
    case socket.assigns[:auto_direction] do
      "inc" ->
        {:noreply, assign(socket, :auto_direction, "dec")}
      "dec" ->
        {:noreply, assign(socket, :auto_direction, "inc")}
    end
  end
end
