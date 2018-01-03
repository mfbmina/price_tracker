defmodule PriceTracker.Product do
  use Ecto.Schema

  schema "products" do
    field :external_product_id, :string
    field :price, :integer
    field :product_name, :string

    timestamps()
  end

  def changeset(product, params \\ %{}) do
    product
    |> Ecto.Changeset.cast(params, [:external_product_id, :price, :product_name])
    |> Ecto.Changeset.validate_required([:external_product_id, :price, :product_name])
  end
end
