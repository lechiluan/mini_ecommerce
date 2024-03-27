defmodule MiniEcommerce.Repo.Migrations.InsertDataBrands do
  use Ecto.Migration

  # use to apply the migration
  def up do
    execute("INSERT INTO brand (name, inserted_at, updated_at) VALUES ('Apple', NOW(), NOW())")
    execute("INSERT INTO brand (name, inserted_at, updated_at) VALUES ('Samsung', NOW(), NOW())")
  end

  # use to rollback the migration
  def down do
    execute("DELETE FROM brand WHERE name = 'Apple'")
    execute("DELETE FROM brand WHERE name = 'Samsung'")
  end
end
