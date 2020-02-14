defmodule SJCCHoopsWeb.Hooks.SessionController do
  use SJCCHoopsWeb, :controller

  def create(conn, %{"session" => %{"date" => date_param}}) do
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
end
