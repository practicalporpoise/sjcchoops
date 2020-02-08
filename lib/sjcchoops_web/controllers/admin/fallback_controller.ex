defmodule SJCCHoopsWeb.Admin.FallbackController do
  use SJCCHoopsWeb, :controller

  @error_msgs %{
    create: "Sorry, there was an issue creating the player.",
    update: "Sorry, there was an issue updating the player."
  }

  @error_tmplts %{
    create: "new.html",
    update: "edit.html"
  }

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(SJCCHoopsWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, msg}) when is_binary(msg) do
    conn
    |> put_flash(:error, msg)
    |> redirect(to: Routes.admin_user_path(conn, :index))
  end

  def call(conn, {:error, _}) do
    conn
    |> put_status(500)
    |> put_view(SJCCHoopsWeb.ErrorView)
    |> render(:"500")
  end

  def call(conn, %Ecto.Changeset{} = changeset) do
    name = action_name(conn)

    conn
    |> put_flash(:error, Map.get(@error_msgs, name, "Sorry, there was an issue."))
    |> render(Map.get(@error_tmplts, name), changeset: changeset)
  end
end
