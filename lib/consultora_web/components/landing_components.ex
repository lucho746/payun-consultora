# lib/consultora_web/components/landing_components.ex
defmodule ConsultoraWeb.LandingComponents do
  use Phoenix.Component

  attr :class, :string, default: nil
  attr :variant, :string, default: "primary", values: ["primary", "secondary", "outline"]
  attr :rest, :global

  slot :inner_block, required: true

  def landing_button(assigns) do
    ~H"""
    <button
      type="button"
      class={[
        "inline-flex items-center justify-center gap-2 rounded-full px-7 py-3.5 text-base font-bold shadow-lg transition",
        button_variant(@variant),
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </button>
    """
  end

  defp button_variant("primary"), do: "bg-sun hover:bg-sun-dark text-ink shadow-ink/20"

  defp button_variant("secondary"),
    do: "bg-earth hover:bg-earth-dark text-white shadow-earth/20"

  defp button_variant("outline"),
    do:
      "border border-white/40 bg-white/10 text-white backdrop-blur hover:bg-white/20 shadow-black/10"
end
