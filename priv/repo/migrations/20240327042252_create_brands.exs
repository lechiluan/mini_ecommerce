defmodule MiniEcommerce.Repo.Migrations.CreateBrands do
  use Ecto.Migration

  def change do
    create table(:brand) do
      add :name, :string

      timestamps()
    end
    
    create index(:brand, [:name])
  end
end
