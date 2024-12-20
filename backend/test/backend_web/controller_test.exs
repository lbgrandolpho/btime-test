defmodule BackendWeb.ControllerTest do
  use Backend.DataCase

  test "GET /api/healthcheck", %{conn: conn} do
    conn = get(conn, "/api/healthcheck")
    assert json_response(conn, 200) == %{"status" => "ok"}
  end
end
