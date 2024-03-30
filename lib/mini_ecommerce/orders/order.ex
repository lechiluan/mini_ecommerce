defmodule MiniEcommerce.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :order_code, :string
    field :total_price, :decimal
    belongs_to :customer, MiniEcommerce.Customers.Customer
    has_many :order_details, MiniEcommerce.OrderDetails.OrderDetail, foreign_key: :order_code

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:order_code, :customer_id, :total_price])
    |> validate_required([:order_code, :customer_id, :total_price])
    |> unique_constraint(:order_code)
  end
end
