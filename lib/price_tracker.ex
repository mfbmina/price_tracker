defmodule PriceTracker do
  @moduledoc """
  PriceTracker module
  """

  @client_api Application.get_env(:price_tracker, :client_api)

  @doc """
  Run app to update prices.

  ## Examples

      iex> PriceTracker.call
      :ok

  """
  def call do
    { status, response } = @client_api.make_request(:get)
    case status do
      :ok -> response.body |> update_prices
      :error -> IO.puts "Unexpected error"
    end
  end

  defp update_prices(body) do
    Enum.each body.productRecords, fn(api_product) ->
      product = PriceTracker.Product |> PriceTracker.Repo.get_by(external_product_id: Integer.to_string(api_product.id))
      case { product, api_product.discontinued } do
        { nil, false } -> attributes(api_product) |> PriceTracker.CreateProductService.call
        { %PriceTracker.Product{}, _ } -> PriceTracker.UpdateProductService.call(product, attributes(api_product))
        _ -> nil
      end
    end
  end

  defp convert_price(price) do
    { total, _ } = Regex.replace(~r/\D/, price, "") |> Integer.parse
    total
  end

  defp attributes(product) do
    %{
      external_product_id: Integer.to_string(product.id),
      price: convert_price(product.price),
      product_name: product.name
    }
  end
end
