defmodule PriceTracker.UpdateProductService do
  @moduledoc """
  Updates a product price and create a price change.
  """

  require Logger

  @doc """
  Run to update prices for an existing product if the API name still the same and price is different.

  ## Examples

      iex> { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
      iex> attributes = %{product_name: "name", price: 1000, external_product_id: "1"}
      iex> { status, _ } = PriceTracker.UpdateProductService.call(product, attributes)
      iex> status
      :ok

      iex> { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
      iex> attributes = %{product_name: "name", price: 100, external_product_id: "1"}
      iex> PriceTracker.UpdateProductService.call(product, attributes)
      { :ok, nil }

      iex> { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
      iex> attributes = %{product_name: "name 2", price: 1000, external_product_id: "1"}
      iex> { status, _ } = PriceTracker.UpdateProductService.call(product, attributes)
      iex> status
      :error

  """
  def call(product, attributes) do
    case { product.product_name == attributes.product_name, product.price != attributes.price } do
      { true, true } ->
        {status, price_change} = PriceTracker.CreatePriceChangeService.call(product, attributes)
        case status do
          :ok ->
            { update_status, updated_product } = update_product(product, attributes)
            case update_status do
              :ok -> { :ok, updated_product }
              :error ->
                price_change |> PriceTracker.Repo.delete
                { :error, updated_product }
            end
          :error -> { :error, product }
        end
      { false, _ } ->
        mismatch_error(product.product_name, attributes.product_name)
        { :error, product }
      _ -> { :ok, nil }
    end
  end

  defp update_product(product, attributes) do
    product
    |> PriceTracker.Product.changeset(attributes)
    |> PriceTracker.Repo.update
  end

  defp mismatch_error(db_name, api_name) do
    Logger.error "Product name is mismatched. DB: #{db_name} --- API: #{api_name}"
  end
end
