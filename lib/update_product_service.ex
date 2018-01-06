defmodule PriceTracker.UpdateProductService do
  def call(product, attributes) do
    case { product.product_name == attributes.product_name, product.price != attributes.price } do
      { true, true } ->
        {status, price_change} = PriceTracker.CreatePriceChangeService.call(product, attributes)
        case status do
          :ok ->
            case update_product(product, attributes) do
              :ok -> nil
              :error -> price_change |> PriceTracker.Repo.delete
            end
          :error -> nil
        end
      { false, _ } -> mismatch_error(product.product_name, attributes.product_name)
      _ -> nil
    end
  end

  defp update_product(product, attributes) do
    { status, _ } = product
    |> PriceTracker.Product.changeset(attributes)
    |> PriceTracker.Repo.update
    status
  end

  defp mismatch_error(db_name, api_name) do
    IO.puts "ERROR: Product name is mismatched. DB: #{db_name} --- API: #{api_name}"
  end
end
