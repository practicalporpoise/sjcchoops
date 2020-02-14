defmodule SJCCHoopsWeb.Hooks.SessionController do
  use SJCCHoopsWeb, :controller

  @timezone "America/Los_Angeles"

  def create(conn, %{"date" => date_param}) do
    case Date.from_iso8601(date_param) do
      {:ok, date} ->
        SJCCHoops.send_daily_emails(date)

        conn
        |> put_status(:created)
        |> json(%{status: :created})

      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> json(%{status: :bad_request, message: msg})
    end
  end

  def create(conn, _param) do
    create(conn, %{"date" => today()})
  end

  defp today do
    {:ok, right_now} = DateTime.now(@timezone)
    Date.to_iso8601(DateTime.to_date(right_now))
  end
end
