defmodule PriceTracker.Product do
  @moduledoc """
  Product schema.
  """

  use Ecto.Schema

  schema "products" do
    field :external_product_id, :string
    field :price, :integer
    field :product_name, :string

    has_many :price_changes, PriceTracker.PriceChange

    timestamps()
  end

  def changeset(product, params \\ %{}) do
    product
    |> Ecto.Changeset.cast(params, [:external_product_id, :price, :product_name])
    |> Ecto.Changeset.validate_required([:external_product_id, :price, :product_name])
  end
end
