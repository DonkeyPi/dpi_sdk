defmodule HelloWorld.Sample do
  use Dpi.React, app: true
  use Dpi.Tui

  def init(opts) do
    {&main/1, opts}
  end

  defp main(%{cols: cols, rows: rows, title: title}) do
    panel :main, size: {cols, rows} do
      label(:title,
        scale: 4,
        align: :center,
        size: {cols, rows},
        text: title,
        class: @dpi_logo_class
      )
    end
  end
end
