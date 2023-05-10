mix archive.install hex phx_new 1.6.16
mix phx.new hello_phoenix --no-ecto
cd hello_phoenix
cp config/runtime.exs config/dpi.exs
added {:hackney, "~> 1.9"} dep
MIX_ENV=prod mix dpi deps.get
MIX_ENV=prod mix dpi.install
