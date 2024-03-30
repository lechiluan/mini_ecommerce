defmodule MiniEcommerceWeb.OrderView do
  use MiniEcommerceWeb, :view
  alias MiniEcommerceWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{
      id: order.id,
      order_code: order.order_code,
      customer_id: order.customer_id,
      total_price: order.total_price
    }
  end
end
