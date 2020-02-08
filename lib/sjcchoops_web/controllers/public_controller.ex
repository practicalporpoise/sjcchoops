defmodule SJCCHoopsWeb.PublicController do
  use SJCCHoopsWeb, :controller

  @timezone "America/Los_Angeles"

  def index(conn, %{"date" => date_param}) do
    with {:ok, date} <- Date.from_iso8601(date_param),
         {:ok, session} <- SJCCHoops.get_session_by_date(date) do
      render(conn, "index.html", date: date, session: session)
    else
      {:error, :not_found} ->
        render(conn, "index.html", date: date_param, session: nil)

      _ ->
        conn
        |> put_status(:not_found)
        |> put_view(SJCCHoopsWeb.ErrorView)
        |> render(:"404")
    end
  end

  def index(conn, _params) do
    index(conn, %{"date" => today()})
  end

  def update(conn, %{"date" => date, "id" => id}) do
    with {:ok, session} <- SJCCHoops.get_session_by_date(date),
         {:ok, player} <- SJCCHoops.get_player(id),
         {:ok, _} <- SJCCHoops.create_session_player(session, player) do
      conn
      |> put_flash(:success, "Thanks #{first_name(player.name)}, you're signed up!")
      |> redirect(to: Routes.public_path(conn, :index, date))
    else
      _ ->
        conn
        |> put_flash(
          :error,
          "Sorry, there was a problem signing you up."
        )
        |> redirect(to: Routes.public_path(conn, :index))
    end
  end

  defp today do
    {:ok, right_now} = DateTime.now(@timezone)
    Date.to_iso8601(DateTime.to_date(right_now))
  end

  defp first_name(name) do
    name
    |> String.split()
    |> Enum.at(0)
  end
end
