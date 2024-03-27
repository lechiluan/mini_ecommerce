defmodule MiniEcommerce.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :order_code, :string
      add :customer_id, references(:customers, on_delete: :nothing)
      add :total_price, :decimal, precision: 10, scale: 2

      timestamps()
    end

    create unique_index(:orders, [:order_code])
    create index(:orders, [:total_price])
  end
end
