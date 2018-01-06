defmodule PriceTracker do
  @moduledoc """
  Documentation for PriceTracker.
  """

  @doc """
  Hello world.

  ## Examples

      iex> PriceTracker.hello
      :world

  """

  @client_api Application.get_env(:price_tracker, :client_api)

  def call do
    { status, response } = @client_api.make_request(:get)
    case status do
      :ok -> response.body |> update_prices
      :error -> "Unexpected error"
    end
  end

  defp update_prices(body) do
    Enum.each body.productRecords, fn(api_product) ->
      product = PriceTracker.Product |> PriceTracker.Repo.get_by(external_product_id: Integer.to_string(api_product.id))
      case { product, api_product.discontinued } do
        { nil, false } -> attributes(api_product) |> PriceTracker.CreateProductService.call
        _ -> nil
      end
    end
  end

  defp convert_price(price) do
    { total, _trash } = Regex.replace(~r/\D/, price, "")
    |> Integer.parse
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
