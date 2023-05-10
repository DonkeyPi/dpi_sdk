import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hello_phoenix, HelloPhoenixWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "N6tMpRfxEaWaS8S/hCwHOv8CYYsyvifZ+ZD8b9gohk7+RTkp5ahEftXrchXcTYCz",
  server: false

# In test we don't send emails.
config :hello_phoenix, HelloPhoenix.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
