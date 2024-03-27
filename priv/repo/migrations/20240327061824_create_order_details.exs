defmodule MiniEcommerce.Repo.Migrations.CreateOrderDetails do
  use Ecto.Migration

  def change do
    create table(:order_details) do
      add :order_code, references(:orders, on_delete: :nothing)
      add :product_code, references(:products, on_delete: :nothing)
      add :selling_price, :decimal, precision: 10, scale: 2
      add :quantity, :integer
      add :product_name, :string

      timestamps()
    end

    # use index to speed up the search process
    create index(:order_details, [:order_code])
    create index(:order_details, [:product_code])
    create index(:order_details, [:product_name])
    create index(:order_details, [:selling_price])
  end
end
