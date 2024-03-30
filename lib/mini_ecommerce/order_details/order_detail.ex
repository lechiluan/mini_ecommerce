defmodule MiniEcommerce.OrderDetails.OrderDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_details" do
    field :order_code, :string
    field :product_code, :string
    field :selling_price, :decimal
    field :quantity, :integer
    field :product_name, :string

    timestamps()
  end

  @doc false
  def changeset(order_detail, attrs) do
    order_detail
    |> cast(attrs, [:order_code, :product_code, :selling_price, :quantity, :product_name])
    |> validate_required([:order_code, :product_code, :selling_price, :quantity, :product_name])
  end
end

