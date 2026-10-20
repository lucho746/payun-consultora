defmodule ConsultoraWeb.Router do
  use ConsultoraWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ConsultoraWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ConsultoraWeb.Plugs.SEO
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ConsultoraWeb do
    pipe_through :browser

    live "/", PageLive.Index, :index
    live "/equipo", EquipoLive, :index
    live "/servicios", ServiciosLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ConsultoraWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:consultora, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ConsultoraWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
