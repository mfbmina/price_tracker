defmodule PriceTracker.CreatePriceChangeService do
  @moduledoc """
  Creates a PriceChange.
  """

  @doc """
  Run to create a PriceChange for an existing product.

  ## Examples

      iex> { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
      iex> attributes = %{product_name: "name", price: 1000, external_product_id: "1"}
      iex> { status, product } = PriceTracker.CreatePriceChangeService.call(product, attributes)
      iex> status
      :ok

  """
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
