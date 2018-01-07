use Mix.Config

config :price_tracker, :client_api, PriceTracker.Client

config :price_tracker, PriceTracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "price_tracker_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
