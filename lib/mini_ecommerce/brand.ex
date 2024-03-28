defmodule MiniEcommerce.Brands do
  import Ecto.Query, warn: false # import Ecto.Query to use the query syntax
  alias MiniEcommerce.Repo # alias the Repo module

  alias MiniEcommerce.Brands.Brand # alias the Brand schema

  def list_brands do
    Repo.all(Brand) # get all brands from the brands table
  end

  def get_brand!(id), do: Repo.get!(Brand, id) # get a brand by id

  # create a brand with the given attributes
  def create_brand(attrs \\ %{}) do
    %Brand{}
    |> Brand.changeset(attrs)
    |> Repo.insert()
  end

  def update_brand(%Brand{} = brand, attrs) do
    brand
    |> Brand.changeset(attrs)
    |> Repo.update()
  end

  def delete_brand(%Brand{} = brand) do
    Repo.delete(brand)
  end
end
