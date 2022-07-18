defmodule ActionsTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ActionsTest.Repo,
      # Start the Telemetry supervisor
      ActionsTestWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ActionsTest.PubSub},
      # Start the Endpoint (http/https)
      ActionsTestWeb.Endpoint
      # Start a worker by calling: ActionsTest.Worker.start_link(arg)
      # {ActionsTest.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ActionsTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ActionsTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end


