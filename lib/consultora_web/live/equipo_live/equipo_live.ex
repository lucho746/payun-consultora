defmodule ConsultoraWeb.EquipoLive do
  use ConsultoraWeb, :live_view

  import ConsultoraWeb.Components.Layout

  def mount(_params, _session, socket) do
    {:ok, assign(socket, expanded_member: nil, page_title: "Nuestro equipo")}
  end

  def handle_event("toggle_bio", %{"member" => member}, socket) do
    expanded_member =
      if socket.assigns.expanded_member == member do
        nil
      else
        member
      end

    {:noreply, assign(socket, expanded_member: expanded_member)}
  end
end
