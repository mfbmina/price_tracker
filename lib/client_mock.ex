defmodule PriceTracker.ClientMock do
  @moduledoc """
  Mock of API client.
  """

  @doc """
  Returns a mocked API response.

  ## Examples

      iex> PriceTracker.ClientMock.get!(nil)
      { :ok, %HTTPoison.Response{body: %{productRecords: [%{category: "home-furnishings",discontinued: false, id: 123456, name: "Nice Chair",price: "$30.25"},%{category: "electronics", discontinued: true, id: 234567,name: "Black & White TV", price: "$43.77"},%{category: "home-furnishings", discontinued: false, id: 123456,name: "Nice Chair 2", price: "$30.25"},%{category: "home-furnishings", discontinued: false, id: 123456,name: "Nice Chair", price: "$39.25"}]}, headers: [],request_url: nil, status_code: nil} }

  """
  def get!(_) do
    {:ok, %HTTPoison.Response{body: %{
          productRecords: [
            %{
              id:  123456,
              name:  "Nice Chair",
              price:  "$30.25",
              category:  "home-furnishings",
              discontinued:  false
            },
            %{
              id:  234567,
              name:  "Black & White TV",
              price:  "$43.77",
              category:  "electronics",
              discontinued:  true
            },
            %{
              id:  123456,
              name:  "Nice Chair 2",
              price:  "$30.25",
              category:  "home-furnishings",
              discontinued:  false
            },
            %{
              id:  123456,
              name:  "Nice Chair",
              price:  "$39.25",
              category:  "home-furnishings",
              discontinued:  false
            }
          ]
        }
      }
    }
  end
end
