defmodule HelloPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    config()

    children = [
      # Start the Telemetry supervisor
      HelloPhoenixWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HelloPhoenix.PubSub},
      # Start the Endpoint (http/https)
      HelloPhoenixWeb.Endpoint
      # Start a worker by calling: HelloPhoenix.Worker.start_link(arg)
      # {HelloPhoenix.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  @app :hello_phoenix

  def rt?(), do: System.get_env("DPI_RT") == "true"
  def path(), do: System.get_env("DPI_PATH")
  def data(), do: System.get_env("DPI_DATA")

  def config(), do: config(rt?(), @app)

  def config(false, _), do: nil

  def config(true, app_name) do
    exsp = Path.join([path(), "lib", "#{app_name}.exs"])
    envp = Path.join([path(), "lib", "#{app_name}.env"])
    IO.inspect("#####################################")
    IO.inspect({exsp, envp})
    content = File.read!(exsp)
    eval = Config.Reader.eval!(exsp, content, env: :prod)
    env = File.read!(envp) |> :erlang.binary_to_term()
    config = Config.Reader.merge(env, eval)
    IO.inspect(config)
    :ok = Application.put_all_env(config, persistent: true)

    # for repo <- Application.fetch_env!(@app, :ecto_repos) do
    #   {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    # end
  end
end
