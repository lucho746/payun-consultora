defmodule ConsultoraWeb.PageControllerTest do
  use ConsultoraWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Gestión ambiental con criterio estratégico"
  end
end
