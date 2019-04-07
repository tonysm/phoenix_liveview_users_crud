defmodule LiveviewTodoWeb.PageController do
  use LiveviewTodoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
