defmodule SJCCHoopsWeb.Router do
  use SJCCHoopsWeb, :router

  alias SJCCHoopsWeb.Plugs.AuthenticateByToken

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :hooks do
    plug :accepts, ["json"]
    plug AuthenticateByToken
  end

  scope "/admin", SJCCHoopsWeb.Admin, as: :admin do
    pipe_through :browser

    get "/", AdminController, :index

    resources "/sessions", SessionController, only: [:new, :create]

    resources "/users", UserController
    post "/users/:id/activate", UserController, :activate
    post "/users/:id/deactivate", UserController, :deactivate
  end

  scope "/hooks", SJCCHoopsWeb.Hooks, as: :hooks do
    pipe_through :hooks

    post "/sessions", SessionController, :create
  end

  scope "/", SJCCHoopsWeb do
    pipe_through :browser

    get "/", PublicController, :index
    get "/:date", PublicController, :index
    get "/:date/:id", PublicController, :update
  end
end
