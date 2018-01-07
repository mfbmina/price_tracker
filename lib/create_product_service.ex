defmodule PriceTracker.CreateProductService do
  @moduledoc """
  Creates a new product.
  """

  @doc """
  Run to create a new product if the product isn't discontinued.

  ## Examples

      iex> { :ok, product } = %PriceTracker.Product{product_name: "name", price: 100, external_product_id: "1"} |> PriceTracker.Repo.insert
      iex> attributes = %{product_name: "name", price: 1000, external_product_id: "1", discontinued: false}
      iex> { status, _product } = PriceTracker.UpdateProductService.call(product, attributes)
      iex> status
      :ok

  """
  def call(attributes) do
    case attributes.discontinued do
      false -> { status, product } = %PriceTracker.Product{}
        |> PriceTracker.Product.changeset(attributes)
        |> PriceTracker.Repo.insert
        case status do
          :ok ->
            IO.puts "Create product ##{product.id}"
            { :ok, product }
          :error -> { :error, product }
        end
      true -> { :ok, nil }
    end
  end
end
