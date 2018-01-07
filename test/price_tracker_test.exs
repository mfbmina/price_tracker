defmodule PriceTrackerTest do
  use ExUnit.Case
  import ExUnit.CaptureLog
  doctest PriceTracker

  test "returns :ok" do
    date_range = Date.range(~D[2018-01-01], Date.utc_today)
    assert PriceTracker.call(date_range) == :ok
  end

  test "logs messages" do
    execute_main = fn ->
      date_range = Date.range(~D[2018-01-01], Date.utc_today)
      PriceTracker.call(date_range)
    end

    assert capture_log(execute_main) =~ "Product name is mismatched."
  end
end
