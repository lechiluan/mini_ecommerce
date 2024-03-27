defmodule MiniEcommerce.Repo.Migrations.InsertDataCustomers do
  use Ecto.Migration

  # use to apply the migration
  def up do
    execute("INSERT INTO customers (full_name, address, phone, birth, inserted_at, updated_at) VALUES ('John Doe', '123 Main St', '1234567890', '1990-01-01', NOW(), NOW())")
    execute("INSERT INTO customers (full_name, address, phone, birth, inserted_at, updated_at) VALUES ('Jane Smith', '456 Elm St', '0987654321', '1995-03-15', NOW(), NOW())")
  end

  # use to rollback the migration
  def down do
    execute("DELETE FROM customers WHERE full_name = 'John Doe'")
    execute("DELETE FROM customers WHERE full_name = 'Jane Smith'")
  end
end
