defmodule MiniEcommerce.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :full_name, :string
      add :address, :string
      add :phone, :string
      add :birth, :date

      timestamps()
    end

    create unique_index(:customers, [:phone])
    create index(:customers, [:full_name])
  end
end
