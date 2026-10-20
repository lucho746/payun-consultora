defmodule ConsultoraWeb.PageLive.Index do
  use ConsultoraWeb, :live_view

  import ConsultoraWeb.Components.Layout
  import ConsultoraWeb.LandingComponents

  alias Consultora.ContactEmail
  alias Consultora.Mailer
  require Logger

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "Consultora ambiental")}
  end

  def handle_event("send_contact", params, socket) do
    case params do
      %{"name" => name, "email" => email, "phone" => phone, "message" => message}
      when name != "" and email != "" and phone != "" and message != "" ->
        params
        |> ContactEmail.contact()
        |> Mailer.deliver()
        |> case do
          {:ok, _} ->
            {:noreply,
             socket
             |> put_flash(:info, "¡Mensaje enviado! Nos pondremos en contacto pronto.")
             |> push_event("reset_contact_form", %{})}

          {:error, _} ->
            {:noreply,
             put_flash(socket, :error, "Hubo un error al enviar el mensaje. Intentá de nuevo.")}
        end

      _ ->
        {:noreply, put_flash(socket, :error, "Por favor completá todos los campos.")}
    end
  end

  def handle_event("download_brochure", _params, socket) do
    Logger.info("download_brochure event received")

    # Generate file (e.g., using CSV, Excel, etc.)
    # For this example, we assume a static file in /priv/static/downloads/
    url = "/downloads/brochure.pdf"
    filename = "brochure.pdf"

    socket = push_event(socket, "download_file", %{url: url, filename: filename})

    {:noreply, socket}
  end

  attr :icon, :string, required: true
  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :href, :string, default: "/servicios"
  attr :tone, :string, default: "brand"

  # Service Card Component
  def service_card(assigns) do
    assigns = assign(assigns, :theme, service_card_theme(assigns.tone))

    ~H"""
    <a
      href={@href}
      class={[
        "group flex h-full flex-col rounded-lg border border-sand bg-paper p-7 shadow-sm transition duration-300 hover:-translate-y-1 hover:shadow-xl hover:shadow-ink/10",
        @theme.border
      ]}
    >
      <span class={["mb-7 flex h-14 w-14 items-center justify-center rounded-lg", @theme.icon]}>
        <.icon name={@icon} class="h-7 w-7" />
      </span>
      <h3 class="text-xl font-extrabold leading-tight text-ink">{@title}</h3>
      <p class="mt-4 flex-1 text-sm leading-6 text-earth/70">{@description}</p>
      <span class={["mt-7 inline-flex items-center gap-2 text-sm font-bold", @theme.link]}>
        Conocer más
        <.icon name="hero-arrow-right-mini" class="h-4 w-4 transition group-hover:translate-x-1" />
      </span>
    </a>
    """
  end

  defp service_card_theme("earth") do
    %{
      icon: "bg-earth-soft text-earth",
      link: "text-earth hover:text-earth-dark",
      border: "hover:border-earth/30"
    }
  end

  defp service_card_theme("slate") do
    %{
      icon: "bg-sand text-ink",
      link: "text-ink hover:text-brand",
      border: "hover:border-earth/40"
    }
  end

  defp service_card_theme("sun") do
    %{
      icon: "bg-sun-soft text-sun-ink",
      link: "text-sun-ink hover:text-earth-dark",
      border: "hover:border-sun-ink/40"
    }
  end

  defp service_card_theme(_) do
    %{
      icon: "bg-brand-soft text-brand",
      link: "text-brand hover:text-brand-dark",
      border: "hover:border-brand/30"
    }
  end

  # Testimonial Component
  def testimonial(assigns) do
    ~H"""
    <div class="bg-paper p-8 rounded-lg shadow-md border border-sand">
      <svg class="w-8 h-8 text-brand mb-4" fill="currentColor" viewBox="0 0 24 24">
        <path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h3.983v10h-9.983z" />
      </svg>
      <blockquote class="text-lg italic text-earth/80 mb-6">
        "{@quote}"
      </blockquote>
      <p class="font-medium text-ink">{@author}</p>
    </div>
    """
  end

  def contact_form(assigns) do
    ~H"""
    <form
      id="contact-form"
      phx-hook="ContactForm"
      phx-submit="send_contact"
      class="rounded-lg border border-sand bg-paper p-6 shadow-xl shadow-ink/10 sm:p-8"
    >
      <div class="grid gap-5">
        <div>
          <label for="name" class="mb-2 block text-sm font-bold text-ink">Nombre</label>
          <input
            type="text"
            id="name"
            name="name"
            class="w-full rounded-lg border-sand bg-paper px-4 py-3 text-ink shadow-sm transition focus:border-brand focus:ring-brand"
            placeholder="Nombre"
            required
          />
        </div>
        <div>
          <label for="email" class="mb-2 block text-sm font-bold text-ink">Email</label>
          <input
            type="email"
            id="email"
            name="email"
            class="w-full rounded-lg border-sand bg-paper px-4 py-3 text-ink shadow-sm transition focus:border-brand focus:ring-brand"
            placeholder="nombre@empresa.com"
            required
          />
        </div>
        <div>
          <label for="phone" class="mb-2 block text-sm font-bold text-ink">Teléfono</label>
          <input
            type="tel"
            id="phone"
            name="phone"
            class="w-full rounded-lg border-sand bg-paper px-4 py-3 text-ink shadow-sm transition focus:border-brand focus:ring-brand"
            placeholder="+54 261 ..."
            required
          />
        </div>
        <div>
          <label for="message" class="mb-2 block text-sm font-bold text-ink">Mensaje</label>
          <textarea
            id="message"
            name="message"
            rows="4"
            class="w-full rounded-lg border-sand bg-paper px-4 py-3 text-ink shadow-sm transition focus:border-brand focus:ring-brand"
            placeholder="Contanos qué necesitás evaluar, presentar o resolver."
            required
          ></textarea>
        </div>
        <button
          type="submit"
          phx-disable-with="Enviando..."
          class="inline-flex w-full items-center justify-center gap-2 rounded-full bg-sun px-6 py-3.5 font-bold text-ink shadow-lg shadow-ink/15 transition hover:bg-sun-dark"
        >
          <.icon name="hero-paper-airplane-mini" class="h-4 w-4" /> Enviar consulta
        </button>
      </div>
    </form>
    """
  end
end
