# defmodule ConsultoraWeb.IndexLive.Show do
#   use ConsultoraWeb, :live_view

#   alias Consultora.Page

#   @impl true
#   def mount(_params, _session, socket) do
#     {:ok, socket}
#   end

#   @impl true
#   def handle_params(%{"id" => id}, _, socket) do
#     {:noreply,
#      socket
#      |> assign(:page_title, page_title(socket.assigns.live_action))
#      |> assign(:index, Page.get_index!(id))}
#   end

#   defp page_title(:show), do: "Show Index"
#   defp page_title(:edit), do: "Edit Index"
# end
