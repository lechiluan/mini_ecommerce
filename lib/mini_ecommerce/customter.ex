defmodule MiniEcommerce.Customers do
  import Ecto.Query, warn: false # import Ecto.Query to use the query syntax
  alias MiniEcommerce.Repo # alias the Repo module

  alias MiniEcommerce.Customers.Customer # alias the Customer schema

  def list_customers do
    Repo.all(Customer) # get all brands from the brands table
  end

  def get_customer!(id) do
    Repo.get!(Customer, id) # get a customer with the given id
end


  def create_customer(attrs) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  def update_customer(customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  def delete_customer(customer) do
    Repo.delete(customer) # delete the customer
  end
end
