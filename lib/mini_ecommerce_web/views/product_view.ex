defmodule MiniEcommerceWeb.ProductView do
  use MiniEcommerceWeb, :view
  alias MiniEcommerceWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      product_code: product.product_code,
      product_name: product.product_name,
      selling_price: product.selling_price,
      brand_id: product.brand_id,
      brand_name: product.brand.name
    }
  end
end
