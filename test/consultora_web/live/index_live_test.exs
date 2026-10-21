defmodule ConsultoraWeb.IndexLiveTest do
  use ConsultoraWeb.ConnCase

  import Phoenix.LiveViewTest
  import Swoosh.TestAssertions

  test "contact form sends from the website domain and replies to the visitor", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    html =
      view
      |> form("form[phx-submit=send_contact]", %{
        name: "Ana",
        email: "ana@example.com",
        phone: "123456789",
        message: "Necesito una consulta ambiental."
      })
      |> render_submit()

    assert html =~ "¡Mensaje enviado!"
    assert_push_event(view, "reset_contact_form", %{})

    assert_email_sent(fn email ->
      assert email.from == {"Formulario Web Payún", "contacto@payunconsultora.com.ar"}
      assert email.to == [{"Payún Consultora", "payunconsultora@gmail.com"}]
      assert email.reply_to == {"Ana", "ana@example.com"}
      assert email.text_body =~ "Necesito una consulta ambiental."
    end)
  end

  test "incomplete contact form does not send or reset", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    html =
      render_submit(view, "send_contact", %{
        "name" => "Ana",
        "email" => "ana@example.com",
        "phone" => "123",
        "message" => ""
      })

    assert html =~ "Por favor completá todos los campos."
    refute_email_sent()
    refute_push_event(view, "reset_contact_form", %{})
  end

  test "home renders the modern landing sections", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/")

    assert html =~ "PAYÚN"
    assert html =~ "Acompañamiento para todas las etapas del proyecto"
    assert html =~ "Trayectoria y experiencia"
    assert html =~ "Hablemos de tu proyecto"
  end

  test "services page renders all service anchors", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/servicios")

    assert html =~ ~s(id="evaluacion-planificacion")
    assert html =~ ~s(id="gestion-cumplimiento")
    assert html =~ ~s(id="sostenibilidad")
    assert html =~ ~s(id="gestion-social")
  end

  test "team page expands founder biographies", %{conn: conn} do
    {:ok, view, html} = live(conn, ~p"/equipo")

    refute html =~ "Ha liderado estudios ambientales"

    html =
      view
      |> element(~s(button[phx-value-member="caro"]))
      |> render_click()

    assert html =~ "Ha liderado estudios ambientales"
  end
end
