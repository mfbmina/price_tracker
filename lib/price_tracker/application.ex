defmodule PriceTracker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: PriceTracker.Worker.start_link(arg)
      # {PriceTracker.Worker, arg},
      PriceTracker.Repo,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PriceTracker.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
