defmodule PriceTracker.CreateProduct do
  @client_api Application.get_env(:price_tracker, :client_api)

  def get do
    @client_api.make_request(:get)
  end
end
