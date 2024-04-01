defmodule MiniEcommerceWeb.OrderDetailController do
  use MiniEcommerceWeb, :controller

  alias MiniEcommerce.OrderDetails
  alias MiniEcommerce.OrderDetails.OrderDetail

  def index(conn, _params) do
    order_details = OrderDetails.list_order_details()
    render(conn, "index.json", order_details: order_details)
  end

  def show(conn, %{"id" => id}) do
    order_detail = OrderDetails.get_order_detail!(id)
    render(conn, "show.json", order_detail: order_detail)
  end

  import MiniEcommerce.OrderDetails.OrderDetail

  def create(conn, %{"order_detail" => order_detail_params}) when is_map(order_detail_params) do
    with {:ok, %OrderDetail{} = order_detail} <- OrderDetails.create_order_detail(order_detail_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_detail_path(conn, :show, order_detail))
      |> render("show.json", order_detail: order_detail)
    end
  end

  def update(conn, %{"id" => id, "order_detail" => order_detail_params}) do
    order_detail = OrderDetails.get_order_detail!(id)

    with {:ok, %OrderDetail{} = order_detail} <- OrderDetails.update_order_detail(order_detail, order_detail_params) do
      render(conn, "show.json", order_detail: order_detail)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_detail = OrderDetails.get_order_detail!(id)

    with {:ok, %OrderDetail{}} <- OrderDetails.delete_order_detail(order_detail) do
      send_resp(conn, :no_content, "")
    end
  end

  @spec get_order_detail_by_order_code(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def get_order_detail_by_order_code(conn, %{"order_code" => order_code}) do
    order_details = OrderDetails.get_order_detail_by_order_code(order_code)
    render(conn, "index.json", order_details: order_details)
  end

end
