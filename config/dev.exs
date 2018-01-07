use Mix.Config

config :price_tracker, :client_api, PriceTracker.ClientMock

config :price_tracker, PriceTracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "price_tracker_dev_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
