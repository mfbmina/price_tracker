defmodule PriceTracker.CreateProductServiceTest do
  use ExUnit.Case
  import ExUnit.CaptureLog
  doctest PriceTracker.CreateProductService

  test "creates a Product" do
    attributes = %{product_name: "name", price: 1000, external_product_id: "1", discontinued: false}
    { status, _ } = PriceTracker.CreateProductService.call(attributes)
    assert status == :ok
  end

  test "logs successful message when creates a Product" do
    execute_main = fn ->
      attributes = %{product_name: "name", price: 1000, external_product_id: "1", discontinued: false}
      PriceTracker.CreateProductService.call(attributes)
    end

    assert capture_log(execute_main) =~ "Create product #"
  end

  test "returns :error when create fails" do
    attributes = %{product_name: "name", price: 1000, discontinued: false}
    { status, _ } = PriceTracker.CreateProductService.call(attributes)
    assert status == :error
  end

  test "not print successful message when a error happens" do
    execute_main = fn ->
      attributes = %{product_name: "name", price: 1000, discontinued: false}
      PriceTracker.CreateProductService.call(attributes)
    end

    refute capture_log(execute_main) =~ "Create product #"
  end

  test "do nothing when product is discontinued" do
    attributes = %{product_name: "name", price: 1000, external_product_id: "1", discontinued: true}
    assert { :ok, nil } == PriceTracker.CreateProductService.call(attributes)
  end

  test "not print successful message when product is discontinued" do
    execute_main = fn ->
      attributes = %{product_name: "name", price: 1000, external_product_id: "1", discontinued: true}
      PriceTracker.CreateProductService.call(attributes)
    end

    refute capture_log(execute_main) =~ "Create product #"
  end
end
