defmodule SandshellApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias :poolboy, as: Poolboy

  @impl true
  def start(_type, _args) do
    database_pool_config = Application.get_env(:sandshell_api, :couchdb_pool)

    children = [
      SandshellApi.Telemetry,
      {DNSCluster, query: Application.get_env(:sandshell_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SandshellApi.PubSub},

      # Start the Finch HTTP client for sending emails
      {Finch, name: SandshellApi.Finch},

      # Start a worker by calling: SandshellApi.Worker.start_link(arg)
      # {SandshellApi.Worker, arg},
      # Start to serve requests, typically the last entry
      SandshellApi.Endpoint,

      # DB Pool
      Poolboy.child_spec(database_pool_config[:name], database_pool_config)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SandshellApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SandshellApi.Endpoint.config_change(changed, removed)
    :ok
  end
end
