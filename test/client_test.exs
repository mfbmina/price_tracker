defmodule PriceTracker.ClientTest do
  use ExUnit.Case
  doctest PriceTracker.Client

  test "returns the API URL" do
    date_range = Date.range(~D[2018-01-01], Date.utc_today)
    response = PriceTracker.Client.process_url(date_range)
    assert response =~ "https://omegapricinginc.com/pricing/records.json"
    assert response =~ "start_date=2018-01-01"
    assert response =~ "end_date=#{Date.utc_today |> Date.to_string}"
  end
end
