defmodule MiniEcommerce.Brands.Brand do
  use Ecto.Schema
  import Ecto.Changeset

  # create a schema for the brands table
  schema "brands" do
    field :name, :string

    timestamps()
  end

  # create a changeset for the brands table to validate the input
  @doc false
  def changeset(brand, attrs) do
    brand
    |> cast(attrs, [:name]) # cast the input
    |> validate_required([:name]) # validate the input
    |> unique_constraint(:name) # validate the uniqueness of the brand_name
  end
end
