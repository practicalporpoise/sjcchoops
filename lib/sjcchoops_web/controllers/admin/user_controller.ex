defmodule SJCCHoopsWeb.Admin.UserController do
  use SJCCHoopsWeb, :controller
  alias SJCCHoops.{Player}

  @fallback_controller SJCCHoopsWeb.Admin.FallbackController

  action_fallback @fallback_controller

  def index(conn, _params) do
    players = SJCCHoops.list_players()
    render(conn, "index.html", players: players)
  end

  def new(conn, _params) do
    changeset = SJCCHoops.change_player(%Player{})
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    with {:ok, player} <- SJCCHoops.get_player(id) do
      changeset = SJCCHoops.change_player(player)
      render(conn, "edit.html", changeset: changeset)
    end
  end

  def create(conn, %{"player" => %{"name" => name, "email" => email}}) do
    with {:ok, player} <- SJCCHoops.create_player(%{name: name, email: email}) do
      conn
      |> put_flash(:success, "Added #{player.name}!")
      |> redirect(to: Routes.admin_user_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "player" => player_params}) do
    with {:ok, player} <- SJCCHoops.get_player(id),
         {:ok, player} <- SJCCHoops.update_player(player, player_params) do
      conn
      |> put_flash(:success, "Updated #{player.name}!")
      |> redirect(to: Routes.admin_user_path(conn, :index))
    end
  end

  def activate(conn, %{"id" => id}) do
    with {:error, %Ecto.Changeset{}} <- update(conn, %{"id" => id, "player" => %{active: true}}) do
      fallback(conn, "Sorry, could not activate the player.")
    end
  end

  def deactivate(conn, %{"id" => id}) do
    with {:error, %Ecto.Changeset{}} <- update(conn, %{"id" => id, "player" => %{active: false}}) do
      fallback(conn, "Sorry, could not deactivate the player.")
    end
  end

  defp fallback(conn, msg) do
    @fallback_controller.call(conn, {:error, msg})
  end
end
