defmodule PriceTracker.CreateProductTest do
  use ExUnit.Case
  alias PriceTracker.CreateProduct

  test "retrieving user" do
    assert %{"login" => "mwoods79"} = response.body
    assert %{"avatar_url" => _} = response.body
  end
end
