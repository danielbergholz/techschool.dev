import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :techschool, Techschool.Repo,
  database: Path.expand("../techschool_test.db", Path.dirname(__ENV__.file)),
  pool_size: System.schedulers_online() * 2,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :techschool, TechschoolWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "xbaWXSZvQ03Bmd0SyCQ851rwvMcDyXEAkOcF4BvZWMlm/ZOJv7/tzqRRBbwfSXcE",
  server: false

# In test we don't send emails.
config :techschool, Techschool.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
