defmodule PriceTracker.ClientMockTest do
  use ExUnit.Case
  doctest PriceTracker.ClientMock

  test "returns the mocked response" do
    assert PriceTracker.ClientMock.get!(nil) == { :ok, %HTTPoison.Response{body: %{
      productRecords: [
        %{category: "home-furnishings",discontinued: false, id: 123456, name: "Nice Chair",price: "$30.25"},
        %{category: "electronics", discontinued: true, id: 234567,name: "Black & White TV", price: "$43.77"},
        %{category: "home-furnishings", discontinued: false, id: 123456,name: "Nice Chair 2", price: "$30.25"},
        %{category: "home-furnishings", discontinued: false, id: 123456,name: "Nice Chair", price: "$39.25"}]}} }
  end
end
