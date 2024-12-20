defmodule BackendWeb.Controller do
  use BackendWeb, :controller

  def index(conn, _params) do
    json(conn, %{status: "ok"})
  end
end
