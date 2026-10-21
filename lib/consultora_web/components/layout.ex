# lib/consultora_web/components/layout.ex
defmodule ConsultoraWeb.Components.Layout do
  use Phoenix.Component

  import ConsultoraWeb.CoreComponents, only: [icon: 1]

  attr :class, :string, default: nil

  def navbar_home(assigns) do
    assigns =
      assign(assigns, :links, [
        %{href: "#nosotros", label: "Nosotras"},
        %{href: "#servicios", label: "Servicios"},
        %{href: "#sectores", label: "Sectores"}
      ])

    ~H"""
    <.navbar links={@links} cta_href="#contacto" class={@class} />
    """
  end

  attr :class, :string, default: nil

  def navbar_other(assigns) do
    assigns =
      assign(assigns, :links, [
        %{href: "/", label: "Inicio"},
        %{href: "/equipo", label: "Equipo"},
        %{href: "/servicios", label: "Servicios"}
      ])

    ~H"""
    <.navbar links={@links} cta_href="/#contacto" class={@class} />
    """
  end

  attr :links, :list, required: true
  attr :cta_href, :string, required: true
  attr :class, :string, default: nil

  defp navbar(assigns) do
    ~H"""
    <nav class={[
      "sticky top-0 z-50 border-b border-sand/90 bg-paper/90 shadow-sm shadow-ink/5 backdrop-blur-xl",
      @class
    ]}>
      <div class="mx-auto flex h-20 max-w-7xl items-center justify-between px-4 sm:px-6 lg:px-8">
        <a href="/" class="flex min-w-0 items-center gap-3 text-ink">
          <span class="flex h-14 w-14 shrink-0 items-center justify-center overflow-hidden rounded-lg bg-paper ring-1 ring-sand">
            <img src="/images/logo.png" alt="Payún Consultora Ambiental" class="h-12 w-auto" />
          </span>
          <span class="min-w-0">
            <span class="block truncate text-xl font-extrabold tracking-normal sm:text-2xl">
              Payún
            </span>
            <span class="hidden text-sm font-medium uppercase tracking-[0.18em] text-earth/65 sm:block">
              Consultora Ambiental
            </span>
          </span>
        </a>

        <div class="hidden items-center gap-5 lg:flex xl:gap-7">
          <a
            :for={link <- @links}
            href={link.href}
            class="text-base font-semibold text-earth/80 transition-colors hover:text-brand"
          >
            {link.label}
          </a>
          <a
            href={@cta_href}
            class="inline-flex items-center gap-2 rounded-full bg-brand px-6 py-3 text-base font-bold text-white shadow-lg shadow-brand/20 transition hover:bg-brand-dark"
          >
            <.icon name="hero-chat-bubble-left-right-mini" class="h-5 w-5" /> Contactar
          </a>
        </div>

        <details class="group relative lg:hidden">
          <summary class="flex h-12 w-12 cursor-pointer list-none items-center justify-center rounded-full border border-sand bg-paper text-ink shadow-sm transition hover:border-brand/40 hover:text-brand">
            <span class="sr-only">Abrir menú</span>
            <.icon name="hero-bars-3" class="h-6 w-6 group-open:hidden" />
            <.icon name="hero-x-mark" class="hidden h-6 w-6 group-open:inline-block" />
          </summary>
          <div class="absolute right-0 mt-3 w-72 rounded-lg border border-sand bg-paper p-3 shadow-2xl shadow-ink/15">
            <a
              :for={link <- @links}
              href={link.href}
              class="block rounded-lg px-4 py-3 text-base font-semibold text-earth/80 transition hover:bg-brand-soft hover:text-brand-dark"
            >
              {link.label}
            </a>
            <a
              href={@cta_href}
              class="mt-2 flex items-center justify-center gap-2 rounded-lg bg-brand px-4 py-3 text-base font-bold text-white"
            >
              <.icon name="hero-chat-bubble-left-right-mini" class="h-5 w-5" /> Contactar
            </a>
          </div>
        </details>
      </div>
    </nav>
    """
  end

  attr :class, :string, default: nil

  def footer(assigns) do
    ~H"""
    <footer id="footer" class={["border-t border-earth bg-ink text-white", @class]}>
      <div class="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
        <div class="grid gap-10 md:grid-cols-4">
          <div class="md:col-span-2">
            <div class="flex items-center gap-3">
              <span class="flex h-12 w-12 items-center justify-center overflow-hidden rounded-lg bg-paper">
                <img src="/images/logo.png" alt="Payún" class="h-11 w-auto" />
              </span>
              <div>
                <h3 class="text-xl font-extrabold">Payún Consultora Ambiental</h3>
              </div>
            </div>
            <p class="mt-6 max-w-xl text-sm leading-6 text-sand">
              Acompañamos proyectos, obras y organizaciones con asesoramiento técnico,
              cumplimiento normativo y mirada territorial.
            </p>
          </div>

          <!-- Middle content -->
          <div>
            <h4 class="mb-4 text-sm font-bold uppercase tracking-[0.18em] text-sand/70">Sitio</h4>
            <ul class="space-y-3 text-sm">
              <li><a href="/" class="text-sand hover:text-white">Inicio</a></li>
              <li><a href="/servicios" class="text-sand hover:text-white">Servicios</a></li>
              <li><a href="/equipo" class="text-sand hover:text-white">Equipo</a></li>
              <li><a href="/#contacto" class="text-sand hover:text-white">Contacto</a></li>
            </ul>
          </div>

          <div>
            <h4 class="mb-4 text-sm font-bold uppercase tracking-[0.18em] text-sand/70">
              Contacto
            </h4>
            <div class="flex flex-wrap gap-3">
              <a
                href="https://www.instagram.com/payun.consultora/"
                target="_blank"
                rel="noopener noreferrer"
                class="flex h-11 w-11 items-center justify-center rounded-full border border-white/10 bg-white/5 text-sand transition hover:border-brand/60 hover:bg-brand hover:text-white"
              >
                <span class="sr-only">Instagram</span>
                <svg
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="1.8"
                  class="h-5 w-5"
                  aria-hidden="true"
                >
                  <rect x="3" y="3" width="18" height="18" rx="5" />
                  <circle cx="12" cy="12" r="4" />
                  <circle cx="17.5" cy="6.5" r="1" fill="currentColor" stroke="none" />
                </svg>
              </a>
              <a
                href="https://www.linkedin.com/in/payunconsultora/"
                target="_blank"
                rel="noopener noreferrer"
                class="flex h-11 w-11 items-center justify-center rounded-full border border-white/10 bg-white/5 text-sm font-black text-white transition hover:border-brand/60 hover:bg-brand"
              >
                <span class="sr-only">LinkedIn</span> in
              </a>
              <a
                href="mailto:payunconsultora@gmail.com"
                target="_blank"
                rel="noopener noreferrer"
                class="flex h-11 w-11 items-center justify-center rounded-full border border-white/10 bg-white/5 text-sand transition hover:border-brand/60 hover:bg-brand hover:text-white"
              >
                <span class="sr-only">Email</span>
                <.icon name="hero-envelope" class="h-5 w-5" />
              </a>
              <a
                href="https://wa.me/5492615135614"
                target="_blank"
                rel="noopener noreferrer"
                class="flex h-11 w-11 items-center justify-center rounded-full border border-white/10 bg-white/5 text-sand transition hover:border-sun/70 hover:bg-sun hover:text-ink"
              >
                <span class="sr-only">WhatsApp</span>
                <.icon name="hero-chat-bubble-left-right" class="h-5 w-5" />
              </a>
            </div>
          </div>
        </div>
        <div class="mt-12 flex flex-col gap-3 border-t border-white/10 pt-8 text-sm text-sand/70 sm:flex-row sm:items-center sm:justify-between">
          <p>&copy; 2026 Payún Consultora Ambiental.</p>
          <p>Mendoza, Argentina</p>
        </div>
      </div>
    </footer>
    """
  end
end
