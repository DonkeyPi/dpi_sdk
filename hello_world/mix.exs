defmodule HelloWorld.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello_world,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :dpi_app],
      mod: {HelloWorld.Application, []}
    ]
  end

  defp deps do
    [
      {:dpi_app, path: "../../dpi_app"},
      {:dpi_tapi, path: "../../dpi_tapi"}
    ]
  end
end
