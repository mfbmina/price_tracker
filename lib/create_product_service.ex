defmodule PriceTracker.CreateProductService do
  def call(attributes) do
    { status, product } = %PriceTracker.Product{}
    |> PriceTracker.Product.changeset(attributes)
    |> PriceTracker.Repo.insert
    case status do
      :ok -> IO.puts "Create product ##{product.id}"
      :error -> nil
    end
  end
end
