defmodule MiniEcommerce.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :product_code, :string
      add :product_name, :string
      add :selling_price, :decimal
      add :brand_id, references(:brands, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:products, [:product_code])
    create index(:products, [:product_name])
    create index(:products, [:selling_price])
  end
end
