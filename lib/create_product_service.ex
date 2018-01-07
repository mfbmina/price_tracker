defmodule PriceTracker.CreateProductService do
  @moduledoc """
  Creates a new product.
  """

  require Logger

  @doc """
  Run to create a new product if the product isn't discontinued.

  ## Examples

      iex> attributes = %{product_name: "name", price: 1000, external_product_id: "1", discontinued: false}
      iex> { status, _product } = PriceTracker.CreateProductService.call(attributes)
      iex> status
      :ok

      iex> attributes = %{product_name: "name", price: 1000, external_product_id: "1", discontinued: true}
      iex> PriceTracker.CreateProductService.call(attributes)
      {:nothing, nil}

  """
  def call(%{discontinued: true}) do
    { :nothing, nil }
  end
  def call(attributes) do
    { status, product } = %PriceTracker.Product{}
    |> PriceTracker.Product.changeset(attributes)
    |> PriceTracker.Repo.insert
    case status do
      :ok ->
        Logger.info "Create product ##{product.id}"
        { :ok, product }
      :error -> { :error, product }
    end
  end
end
