defmodule PriceTracker.ClientTest do
  use ExUnit.Case
  doctest PriceTracker.Client

  test "returns the API URL" do
    assert PriceTracker.Client.process_url("") == "https://omegapricinginc.com/pricing/records.json"
  end
end
