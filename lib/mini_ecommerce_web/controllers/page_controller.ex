defmodule MiniEcommerceWeb.PageController do
  use MiniEcommerceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
