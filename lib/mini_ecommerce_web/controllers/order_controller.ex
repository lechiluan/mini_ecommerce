defmodule MiniEcommerceWeb.OrderController  do
  use MiniEcommerceWeb, :controller

  def index(conn, _params) do
    render(conn, "order.html")
  end
end
