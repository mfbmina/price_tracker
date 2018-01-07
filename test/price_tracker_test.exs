defmodule PriceTrackerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest PriceTracker

  test "returns :ok" do
    assert PriceTracker.call() == :ok
  end

  test "prints messages" do
    execute_main = fn ->
      PriceTracker.call()
    end

    assert capture_io(execute_main) =~ "ERROR: Product name is mismatched."
  end
end
