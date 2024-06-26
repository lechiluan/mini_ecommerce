defmodule MiniEcommerce.Orders do
  import Ecto.Query, warn: false
  alias MiniEcommerce.Repo

  alias MiniEcommerce.Orders.Order

  def list_orders do
    orders = from(o in Order, order_by: o.id)
    |> Repo.all()
    Repo.preload(orders, [:customer])
  end

  def get_order!(id) do
    order = Repo.get!(Order, id)
    Repo.preload(order, [:customer])
  end

  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end

  def search_orders(search) do
    search = to_string(search)

    from(o in Order,
      join: c in assoc(o, :customer),
      where: ilike(o.order_code, ^"%#{search}%") or ilike(c.phone, ^"%#{search}%")
    )
    |> Repo.all()
  end

end
