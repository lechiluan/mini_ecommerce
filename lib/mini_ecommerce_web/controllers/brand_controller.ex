defmodule MiniEcommerceWeb.BrandController do
  use MiniEcommerceWeb, :controller

  alias MiniEcommerce.Brands
  alias MiniEcommerce.Brands.Brand

  action_fallback MiniEcommerceWeb.FallbackController

  def index(conn, _params) do
    brands = Brands.list_brands()
    render(conn, "index.json", brands: brands)
  end

  def create(conn, %{"brand" => brand_params}) do
    with {:ok, %Brand{} = brand} <- Brands.create_brand(brand_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.brand_path(conn, :show, brand))
      |> render("show.json", brand: brand)
    end
  end

  def show(conn, %{"id" => id}) do
    brand = Brands.get_brand!(id)
    render(conn, "show.json", brand: brand)
  end

  def update(conn, %{"id" => id, "brand" => brand_params}) do
    brand = Brands.get_brand!(id)

    with {:ok, %Brand{} = brand} <- Brands.update_brand(brand, brand_params) do
      render(conn, "show.json", brand: brand)
    end
  end

  def delete(conn, %{"id" => id}) do
    brand = Brands.get_brand!(id)

    with {:ok, %Brand{}} <- Brands.delete_brand(brand) do
      send_resp(conn, :no_content, "")
    end
  end
end
