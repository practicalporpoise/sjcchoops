defmodule SJCCHoopsWeb.Admin.AdminController do
  use SJCCHoopsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
