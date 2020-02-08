defmodule SJCCHoopsWeb.Admin.SessionController do
  use SJCCHoopsWeb, :controller

  alias SJCCHoops.DateHelpers

  @timezone "America/Los_Angeles"

  def new(conn, _params) do
    render(conn, "new.html", date: today())
  end

  def create(conn, %{"session" => %{"date" => date_param}}) do
    case Date.from_iso8601(date_param) do
      {:ok, date} ->
        SJCCHoops.send_daily_emails(date)

        conn
        |> put_flash(:success, "Sent emails for #{DateHelpers.long_format(date)}!")
        |> redirect(to: Routes.admin_session_path(conn, :new))

      {:error, msg} ->
        conn
        |> put_flash(:error, "Sorry, could not send emails: #{msg}")
        |> redirect(to: Routes.admin_session_path(conn, :new))
    end
  end

  defp today do
    {:ok, right_now} = DateTime.now(@timezone)
    Date.to_iso8601(DateTime.to_date(right_now))
  end
end
