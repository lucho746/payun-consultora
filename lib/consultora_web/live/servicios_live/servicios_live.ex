defmodule ConsultoraWeb.ServiciosLive do
  use ConsultoraWeb, :live_view

  import ConsultoraWeb.Components.Layout

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "Servicios de consultoría ambiental")}
  end

  attr :id, :string, required: true
  attr :eyebrow, :string, required: true
  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :items, :list, required: true
  attr :icon, :string, required: true
  attr :image, :string, required: true
  attr :tone, :string, default: "brand"
  attr :surface, :string, default: "white"
  attr :reverse, :boolean, default: false

  def service_page_section(assigns) do
    assigns =
      assigns
      |> assign(:theme, service_theme(assigns.tone))
      |> assign(:surface_class, surface_class(assigns.surface))

    ~H"""
    <section id={@id} class={["py-20 sm:py-24", @surface_class]}>
      <div class="mx-auto grid max-w-7xl gap-12 px-4 sm:px-6 lg:grid-cols-2 lg:items-center lg:px-8">
        <div class="max-w-xl">
          <p class={["text-sm font-bold uppercase tracking-[0.18em]", @theme.eyebrow]}>
            {@eyebrow}
          </p>
          <h2 class="mt-3 text-3xl font-black tracking-normal text-ink sm:text-4xl">
            {@title}
          </h2>
          <p class="mt-5 text-lg leading-8 text-earth/70">
            {@description}
          </p>

          <ul class="mt-8 grid gap-3">
            <li
              :for={item <- @items}
              class="flex items-start gap-3 rounded-lg border border-sand bg-paper p-4 shadow-sm"
            >
              <span class={[
                "mt-0.5 flex h-6 w-6 shrink-0 items-center justify-center rounded-full",
                @theme.check
              ]}>
                <.icon name="hero-check-mini" class="h-4 w-4" />
              </span>
              <span class="text-sm font-semibold leading-6 text-earth/80">{item}</span>
            </li>
          </ul>
        </div>

        <div class={[
          "relative min-h-[400px] overflow-hidden rounded-lg shadow-xl shadow-ink/10 sm:min-h-[440px] lg:self-stretch",
          @reverse && "lg:order-first"
        ]}>
          <img src={@image} alt="" class="absolute inset-0 h-full w-full object-cover" />
          <div class="absolute inset-0 bg-gradient-to-t from-ink/85 via-ink/30 to-transparent"></div>
          <div class={[
            "absolute left-6 top-6 flex h-14 w-14 items-center justify-center rounded-lg bg-paper shadow-lg",
            @theme.visual
          ]}>
            <.icon name={@icon} class="h-8 w-8" />
          </div>
          <div class="absolute inset-x-0 bottom-0 p-6">
            <p class="text-sm font-bold uppercase tracking-[0.18em] text-brand">Servicio</p>
            <p class="mt-2 max-w-md text-2xl font-black leading-tight text-white">
              {@title}
            </p>
          </div>
        </div>
      </div>
    </section>
    """
  end

  defp service_theme("earth") do
    %{
      eyebrow: "text-earth",
      check: "bg-earth text-white",
      visual: "text-earth"
    }
  end

  defp service_theme("sun") do
    %{
      eyebrow: "text-sun-ink",
      check: "bg-sun text-ink",
      visual: "text-sun-ink"
    }
  end

  defp service_theme("slate") do
    %{
      eyebrow: "text-earth/70",
      check: "bg-ink text-white",
      visual: "text-ink"
    }
  end

  defp service_theme(_) do
    %{
      eyebrow: "text-brand",
      check: "bg-brand text-white",
      visual: "text-brand"
    }
  end

  defp surface_class("muted"), do: "bg-sand-light"
  defp surface_class(_), do: "bg-paper"
end
