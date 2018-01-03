defmodule PriceTracker.Repo.Migrations.CreatePriceChanges do
  use Ecto.Migration

  def change do
    create table(:price_changes) do
      add :product_id, references(:products), null: false
      add :price, :integer
      add :percentage_change, :float

      timestamps()
    end
  end
end
