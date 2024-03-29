defmodule MiniEcommerce.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  # create a schema for the customers table
  schema "customers" do
    field :full_name, :string
    field :address, :string
    field :phone, :string
    field :birth, :date

    timestamps()
  end

  # create a changeset for the customers table to validate the input
  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:full_name, :address, :phone, :birth]) # cast the input
    |> validate_required([:full_name, :address, :phone, :birth]) # validate the input
  end
end
