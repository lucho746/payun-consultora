defmodule Consultora.ContactEmail do
  import Swoosh.Email

  @to_address "payunconsultora@gmail.com"
  @from_address "contacto@payunconsultora.com.ar"

  def contact(params) do
    new()
    |> to({"Payún Consultora", @to_address})
    |> from({"Formulario Web Payún", @from_address})
    |> reply_to({params["name"], params["email"]})
    |> subject("Nuevo contacto: #{params["name"]}")
    |> text_body("""
    Nombre:   #{params["name"]}
    Email:    #{params["email"]}
    Teléfono: #{params["phone"]}

    Mensaje:
    #{params["message"]}
    """)
  end
end
