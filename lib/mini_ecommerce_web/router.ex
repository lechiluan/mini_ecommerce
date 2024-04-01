defmodule MiniEcommerceWeb.Router do
  use MiniEcommerceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MiniEcommerceWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/order", OrderController, :order
    get "/order_list", OrderController, :order_list
  end

  # Other scopes may use custom stacks.
  # scope "/api", MiniEcommerceWeb do
  #   pipe_through :api
  # end

  scope "/api", MiniEcommerceWeb do
    pipe_through :api

    resources "/products", ProductController, except: [:new, :edit]
    resources "/brands", BrandController, except: [:new, :edit]
    resources "/customers", CustomerController, except: [:new, :edit]
    resources "/orders", OrderController, except: [:new, :edit]
    resources "/order_details", OrderDetailController, except: [:new, :edit]
    get "/get_order_detail_by_order_code/:order_code", OrderDetailController, :get_order_detail_by_order_code
  end
  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: MiniEcommerceWeb.Telemetry
    end
  end
end
