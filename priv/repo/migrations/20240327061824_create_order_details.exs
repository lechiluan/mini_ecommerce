defmodule MiniEcommerce.Repo.Migrations.CreateOrderDetails do
  use Ecto.Migration

  def change do
    create table(:order_details) do
      add :order_code, :string
      add :product_code, :string
      add :selling_price, :decimal, precision: 10, scale: 2
      add :quantity, :integer
      add :product_name, :string

      timestamps()
    end

    create index(:order_details, [:order_code])
    create index(:order_details, [:product_code])
    create index(:order_details, [:product_name])
    create index(:order_details, [:selling_price])
  end
end
