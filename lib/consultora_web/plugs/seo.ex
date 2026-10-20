defmodule ConsultoraWeb.Plugs.SEO do
  import Plug.Conn

  @base_url "https://payunconsultora.com.ar"
  @pages %{
    "/" =>
      {"Consultora ambiental",
       "En Payún acompañamos proyectos con evaluación de impacto ambiental, gestión, sostenibilidad y participación comunitaria. Conocé nuestros servicios."},
    "/servicios" =>
      {"Servicios de consultoría ambiental",
       "Estudios de impacto ambiental, gestión de residuos, permisos, sostenibilidad, ISO 14001 y formación. Conocé los servicios de Payún Consultora Ambiental."},
    "/equipo" =>
      {"Nuestro equipo",
       "Conocé a las profesionales de Payún Consultora Ambiental y nuestra experiencia en evaluación, gestión ambiental y acompañamiento de proyectos."}
  }

  def init(opts), do: opts

  def call(conn, _opts) do
    {title, description} = Map.get(@pages, conn.request_path, @pages["/"])

    conn
    |> assign(:page_title, title)
    |> assign(:seo_description, description)
    |> assign(:canonical_url, @base_url <> conn.request_path)
    |> assign(:social_image, @base_url <> "/images/payun.jpg")
  end
end
