defmodule Backend.Application do
  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: Backend.PubSub},
      Backend.Repo,
      BackendWeb.Endpoint,
      {Absinthe.Subscription, BackendWeb.Endpoint}
    ]

    opts = [strategy: :one_for_one, name: Backend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
