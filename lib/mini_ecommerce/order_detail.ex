# lib/mini_ecommerce/order_details/order_details.ex
defmodule MiniEcommerce.OrderDetails do
  import Ecto.Query, warn: false
  alias MiniEcommerce.Repo

  alias MiniEcommerce.OrderDetails.OrderDetail

  def list_order_details do
    Repo.all(OrderDetail)
  end

  def get_order_detail!(id) do
    Repo.get!(OrderDetail, id)
  end

  def create_order_detail(attrs) do
    %OrderDetail{}
    |> OrderDetail.changeset(attrs)
    |> Repo.insert()
  end

  def update_order_detail(order_detail, attrs) do
    order_detail
    |> OrderDetail.changeset(attrs)
    |> Repo.update()
  end

  def delete_order_detail(order_detail) do
    Repo.delete(order_detail)
  end
end
