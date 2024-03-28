defmodule MiniEcommerce.Products do
  import Ecto.Query, warn: false # import Ecto.Query to use the query syntax
  alias MiniEcommerce.Repo # alias the Repo module

  alias MiniEcommerce.Products.Product # alias the Product schema


  def list_products do
    products = from(p in Product, order_by: p.id) #
    |> Repo.all()
    Repo.preload(products, [:brand])
  end

  def get_product!(id) do
    product = Repo.get!(Product, id) # get a product with the given id
    Repo.preload(product, :brand)
  end

  def create_product(attrs) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end


  def delete_product(product) do
    Repo.delete(product) # delete the product
  end

end
