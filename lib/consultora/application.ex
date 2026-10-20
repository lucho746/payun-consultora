defmodule Consultora.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ConsultoraWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:consultora, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Consultora.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Consultora.Finch},
      # Start a worker by calling: Consultora.Worker.start_link(arg)
      # {Consultora.Worker, arg},
      # Start to serve requests, typically the last entry
      ConsultoraWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Consultora.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ConsultoraWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
