defmodule HelloWorld.Application do
  use Application

  @title "Hello World"
  @driver Dpi.Tui.Driver
  @term Dpi.Term.Console
  @delay 400

  def start(_type, _args) do
    children = [
      {
        HelloWorld.Sample,
        title: @title, driver: @driver, term: @term, delay: @delay, select: true
      }
    ]

    Supervisor.start_link(
      children,
      strategy: :one_for_one,
      max_restarts: 10,
      max_seconds: 1,
      name: __MODULE__
    )
  end

  def stop(_), do: :init.stop()
end
