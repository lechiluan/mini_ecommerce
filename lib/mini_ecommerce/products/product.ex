defmodule MiniEcommerce.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  
  # create a schema for the products table
  schema "products" do
    field :product_code, :string
    field :product_name, :string
    field :selling_price, :decimal
    belongs_to :brand, MiniEcommerce.Brands.Brand

    timestamps()
  end

  # create a changeset for the products table to validate the input
  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:product_code, :product_name, :selling_price, :brand_id]) # cast the input
    |> validate_required([:product_code, :product_name, :selling_price, :brand_id]) # validate the input
    |> unique_constraint(:product_code) # validate the uniqueness of the product_code
  end
end
