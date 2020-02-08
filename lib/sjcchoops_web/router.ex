defmodule SJCCHoopsWeb.Router do
  use SJCCHoopsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/admin", SJCCHoopsWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/sessions", SessionController, only: [:new, :create]

    resources "/users", UserController
    post "/users/:id/activate", UserController, :activate
    post "/users/:id/deactivate", UserController, :deactivate
  end

  scope "/", SJCCHoopsWeb do
    pipe_through :browser

    get "/", PublicController, :index
    get "/:date", PublicController, :index
    get "/:date/:id", PublicController, :update
  end

  match(_, do: send_resp(conn, 404, "Not found"))
end
