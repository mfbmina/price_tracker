defmodule PriceTracker.Mixfile do
  use Mix.Project

  def project do
    [
      app: :price_tracker,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PriceTracker.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.12", only: [:dev, :test]},
      {:ecto, "~> 2.0"},
      {:postgrex, "~> 0.11"},
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false}
    ]
  end
end
