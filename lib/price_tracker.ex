defmodule PriceTracker do
  @moduledoc """
  PriceTracker module
  """

  @client_api Application.get_env(:price_tracker, :client_api)

  @doc """
  Run app to update prices.

  ## Examples

      iex> date_range = Date.range(~D[2018-01-01], Date.utc_today)
      iex> PriceTracker.call(date_range)
      :ok

  """
  def call(date_range) do
    {status, response} = @client_api.get!(date_range)
    case status do
      :ok -> response.body |> update_prices
      :error -> IO.puts "Unexpected error"
    end
  end

  defp update_prices(body) do
    Enum.each body.productRecords, fn(api_product) ->
      product = PriceTracker.Product |> PriceTracker.Repo.get_by(external_product_id: Integer.to_string(api_product.id))
      case product do
        nil -> api_product |> attributes |> PriceTracker.CreateProductService.call
        %PriceTracker.Product{} -> PriceTracker.UpdateProductService.call(product, attributes(api_product))
      end
    end
  end

  defp convert_price(price) do
    {total, _} = ~r/\D/ |> Regex.replace(price, "") |> Integer.parse
    total
  end

  defp attributes(product) do
    %{
      external_product_id: Integer.to_string(product.id),
      price: convert_price(product.price),
      product_name: product.name,
      discontinued: product.discontinued
    }
  end
end
