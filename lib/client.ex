defmodule PriceTracker.Client do
  @moduledoc """
  API Client.
  """

  use HTTPoison.Base

  @doc """
  Returns the URL for fetching products.

  ## Examples

      iex> date_range = Date.range(~D[2018-01-01], Date.utc_today)
      iex> PriceTracker.Client.process_url(date_range) =~ "https://omegapricinginc.com/pricing/records.json"
      true

  """
  def process_url(date_range) do
    date_params = "start_date=#{date_range.first |> Date.to_string}&end_date=#{date_range.last |> Date.to_string}"
    "https://omegapricinginc.com/pricing/records.json?api_key=#{System.get_env("API_KEY")}&#{date_params}"
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
