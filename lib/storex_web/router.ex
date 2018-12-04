defmodule StorexWeb.Router do
  use StorexWeb, :router

  alias StorexWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plugs.Cart
    plug Plugs.ItemsCount
    plug Plugs.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StorexWeb do
    pipe_through :browser # Use the default browser stack


    get "/", VideoController, :index
    get "/purchased", VideoController, :purchased
    resources "/videos", VideoController
    get "/watch/:id", WatchController, :show

    resources "/carts", CartController, singleton: true, only: [:show, :create, :delete]
    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, singleton: true, only: [:new, :create, :delete]
    resources "/checkout", CheckoutController, only: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", StorexWeb do
  #   pipe_through :api
  # end
end
