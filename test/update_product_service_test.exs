defmodule PriceTracker.UpdateProductServiceTest do
  use ExUnit.Case
  import ExUnit.CaptureLog
  doctest PriceTracker.UpdateProductService

  test "updates the Product when name is the same and price is different" do
    { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
    attributes = %{product_name: "name", price: 1010, external_product_id: "1"}
    { status, updated_product } = PriceTracker.UpdateProductService.call(product, attributes)
    assert status == :ok
    refute updated_product.price == product.price
  end

  test "not print error message when update is successfull" do
    execute_main = fn ->
      { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
      attributes = %{product_name: "name", price: 1010, external_product_id: "1"}
      PriceTracker.UpdateProductService.call(product, attributes)
    end

    refute capture_log(execute_main) =~ "ERROR: Product name is mismatched."
  end

  test "returns :ok when there are no differences" do
    { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
    attributes = %{product_name: "name", price: 100, external_product_id: "1"}
    assert { :nothing, nil } == PriceTracker.UpdateProductService.call(product, attributes)
  end

  test "not print error message when there are no differences" do
    execute_main = fn ->
      { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
      attributes = %{product_name: "name", price: 100, external_product_id: "1"}
      PriceTracker.UpdateProductService.call(product, attributes)
    end

    refute capture_log(execute_main) =~ "ERROR: Product name is mismatched."
  end

  test "returns :error when name is different" do
    { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
    attributes = %{product_name: "name 2", price: 100, external_product_id: "1"}
    assert { :error, product } == PriceTracker.UpdateProductService.call(product, attributes)
  end

  test "logs error message when name is different" do
    execute_main = fn ->
      { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
      attributes = %{product_name: "name 2", price: 100, external_product_id: "1"}
      PriceTracker.UpdateProductService.call(product, attributes)
    end

    assert capture_log(execute_main) =~ "Product name is mismatched."
  end
end
