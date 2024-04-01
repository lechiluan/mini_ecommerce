defmodule MiniEcommerce.Repo.Migrations.InsertDataBrands do
  use Ecto.Migration

  # use to apply the migration
  def up do
    execute("INSERT INTO brands (name, inserted_at, updated_at) VALUES ('Apple', NOW(), NOW())")
    execute("INSERT INTO brands (name, inserted_at, updated_at) VALUES ('Samsung', NOW(), NOW())")
    execute "INSERT INTO brands (name, inserted_at, updated_at) VALUES ('Xiaomi', NOW(), NOW())"
    execute("INSERT INTO products (product_code, product_name, selling_price, brand_id, inserted_at, updated_at) VALUES ('IP12', 'Iphone 12', 150, 1, NOW(), NOW())")
    execute("INSERT INTO products (product_code, product_name, selling_price, brand_id, inserted_at, updated_at) VALUES ('IP11', 'Iphone 11', 130, 1, NOW(), NOW())")
    execute("INSERT INTO products (product_code, product_name, selling_price, brand_id, inserted_at, updated_at) VALUES ('IP10', 'Iphone 10', 160, 1, NOW(), NOW())")
    execute("INSERT INTO products (product_code, product_name, selling_price, brand_id, inserted_at, updated_at) VALUES ('S21', 'Samsung S21', 200, 2, NOW(), NOW())")
  end

  # use to rollback the migration
  def down do
    execute("DELETE FROM products WHERE product_code IN ('IP12', 'IP11', 'IP10', 'S21')")
    execute("DELETE FROM brands WHERE name = 'Apple'")
    execute("DELETE FROM brands WHERE name = 'Samsung'")
    execute("DELETE FROM brands WHERE name = 'Xiaomi'")
  end
end
