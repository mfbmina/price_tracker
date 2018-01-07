defmodule PriceTracker.CreatePriceChangeServiceTest do
  use ExUnit.Case
  doctest PriceTracker.CreatePriceChangeService

  test "creates a PriceChange" do
    { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
    attributes = %{product_name: "name", price: 1000, external_product_id: "1"}
    { status, _ } = PriceTracker.CreatePriceChangeService.call(product, attributes)
    assert status == :ok
  end
end
