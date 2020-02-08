defmodule SJCCHoops.SessionPlayer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "sessions_players" do
    belongs_to :player, SJCCHoops.Player
    belongs_to :session, SJCCHoops.Session
    timestamps()
  end

  @doc false
  def changeset(session_player, params \\ %{}) do
    session_player
    |> cast(params, [:player_id, :session_id])
    |> validate_required([:player_id, :session_id])
    |> unique_constraint(:player_id, name: :sessions_players_session_id_player_id_index)
  end
end
