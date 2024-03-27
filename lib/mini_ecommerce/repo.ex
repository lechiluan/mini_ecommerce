defmodule MiniEcommerce.Repo do
  use Ecto.Repo,
    otp_app: :mini_ecommerce,
    adapter: Ecto.Adapters.Postgres
end
