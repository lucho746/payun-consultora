defmodule ConsultoraWeb.PageControllerTest do
  use ConsultoraWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Gestión socioambiental clara para la toma de decisiones"
  end
end
