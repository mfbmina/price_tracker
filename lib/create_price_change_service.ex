defmodule PriceTracker.CreatePriceChangeService do
  def call(product, attributes) do
    %PriceTracker.PriceChange{}
    |> PriceTracker.PriceChange.changeset(%{
      product_id: product.id,
      price: product.price,
      percentage_change: attributes.price * 100 / product.price,
    })
    |> PriceTracker.Repo.insert
  end
end
