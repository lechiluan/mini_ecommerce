defmodule MiniEcommerceWeb.CustomerView do
  use MiniEcommerceWeb, :view
  alias MiniEcommerceWeb.CustomerView

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{
      id: customer.id,
      full_name: customer.full_name,
      address: customer.address,
      phone: customer.phone,
      birth: customer.birth
    }
  end

end
