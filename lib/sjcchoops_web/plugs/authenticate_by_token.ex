defmodule SJCCHoopsWeb.Plugs.AuthenticateByToken do
  import Plug.Conn
  import Phoenix.Controller

  @regex ~r/^Bearer\s(?<token>.+)$/

  def init(_params) do
  end

  def call(conn, _params) do
    with [auth_header] <- Plug.Conn.get_req_header(conn, "authorization"),
         %{"token" => token} <- Regex.named_captures(@regex, auth_header),
         {:ok} <- verify_token(token) do
      conn
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> json(%{status: :unauthorized})
        |> halt()
    end
  end

  defp verify_token(token) do
    with {:ok, secret} <- Application.fetch_env(:sjcchoops, :hook_admin_token),
         true <- String.equivalent?(secret, token) do
      {:ok}
    else
      _ -> nil
    end
  end
end
