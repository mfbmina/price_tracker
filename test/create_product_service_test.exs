defmodule PriceTracker.CreateProductServiceTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest PriceTracker.CreateProductService

  test "creates a Product" do
    attributes = %{product_name: "name", price: 1000, external_product_id: "1"}
    { status, _ } = PriceTracker.CreateProductService.call(attributes)
    assert status == :ok
  end

  test "prints successful message when creates a Product" do
    execute_main = fn ->
      attributes = %{product_name: "name", price: 1000, external_product_id: "1"}
      PriceTracker.CreateProductService.call(attributes)
    end

    assert capture_io(execute_main) =~ "Create product #"
  end

  test "returns :error when create fails" do
    attributes = %{product_name: "name", price: 1000}
    { status, _ } = PriceTracker.CreateProductService.call(attributes)
    assert status == :error
  end

  test "not print successful message when a error happens" do
    execute_main = fn ->
      attributes = %{product_name: "name", price: 1000}
      PriceTracker.CreateProductService.call(attributes)
    end

    refute capture_io(execute_main) =~ "Create product #"
  end
end
