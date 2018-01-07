defmodule PriceTracker.Client do
  @moduledoc """
  API Client.
  """

  use HTTPoison.Base

  @doc """
  Returns the URL for fetching products.

  ## Examples

      iex> PriceTracker.Client.process_url("") =~ "https://omegapricinginc.com/pricing/records.json"
      true

  """
  def process_url(_url) do
    "https://omegapricinginc.com/pricing/records.json?api_key=#{System.get_env("API_KEY")}"
  end

  @doc """
  Process the response body.
  """
  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
