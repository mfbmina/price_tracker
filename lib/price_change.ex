defmodule PriceTracker.PriceChange do
  use Ecto.Schema

  schema "price_changes" do
    field :price, :integer
    field :percentage_change, :float

    belongs_to :product, PriceTracker.Product

    timestamps()
  end

  def changeset(price_change, params \\ %{}) do
    price_change
    |> Ecto.Changeset.cast(params, [:product_id, :price, :percentage_change])
    |> Ecto.Changeset.validate_required([:product_id, :price, :percentage_change])
  end
end
