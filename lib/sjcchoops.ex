defmodule SJCCHoops do
  @moduledoc """
  SJCCHoops keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  import Ecto.Query

  alias SJCCHoopsWeb.Router.Helpers, as: Routes
  alias SJCCHoops.{Email, Mailer, Player, Repo, Session, SessionPlayer}

  def list_players() do
    Repo.all(Player)
  end

  def list_active_players() do
    Player
    |> where(active: true)
    |> Repo.all()
  end

  def get_player(id) do
    Player
    |> Repo.get(id)
    |> to_tuple()
  end

  def update_player(%Player{} = player, params) do
    player
    |> Player.changeset(params)
    |> Repo.update()
  end

  def create_player(params \\ %{}) do
    %Player{}
    |> Player.changeset(params)
    |> Repo.insert()
  end

  def change_player(player, attrs \\ %{}) do
    Player.changeset(player, attrs)
  end

  def get_session_by_date(date) do
    Session
    |> Repo.get_by(date: date)
    |> Repo.preload([:players])
    |> to_tuple()
  end

  def create_session(date) do
    %Session{}
    |> Session.changeset(%{date: date})
    |> Repo.insert(on_conflict: :nothing)
  end

  def create_session_player(session, player) do
    %SessionPlayer{}
    |> SessionPlayer.changeset(%{player_id: player.id, session_id: session.id})
    |> Repo.insert(on_conflict: :nothing)
  end

  def send_daily_emails(date) do
    with {:ok, _} <- create_session(date) do
      list_active_players()
      |> Enum.each(&send_daily_email(&1, date))
    end
  end

  def send_daily_email(player, date) do
    %{player: player, date: date}
    |> Map.put(:url, daily_url(player, date))
    |> Email.daily()
    |> Mailer.deliver()
  end

  def daily_url(player, date) do
    Routes.public_url(SJCCHoopsWeb.Endpoint, :update, Date.to_string(date), player.id)
  end

  defp to_tuple(nil) do
    {:error, :not_found}
  end

  defp to_tuple(anything) do
    {:ok, anything}
  end
end
