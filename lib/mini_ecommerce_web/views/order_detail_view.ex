defmodule MiniEcommerceWeb.OrderDetailView do
  use MiniEcommerceWeb, :view
  alias MiniEcommerceWeb.OrderDetailView

  def render("index.json", %{order_details: order_details}) do
    %{data: render_many(order_details, OrderDetailView, "order_detail.json")}
  end

  def render("show.json", %{order_detail: order_detail}) do
    %{data: render_one(order_detail, OrderDetailView, "order_detail.json")}
  end

  def render("order_detail.json", %{order_detail: order_detail}) do
    %{
      id: order_detail.id,
      order_code: order_detail.order_code,
      product_code: order_detail.product_code,
      selling_price: order_detail.selling_price,
      quantity: order_detail.quantity,
      product_name: order_detail.product_name
    }
  end
end
