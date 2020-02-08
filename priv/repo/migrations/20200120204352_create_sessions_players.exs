defmodule SJCCHoops.Repo.Migrations.CreateSessionsPlayers do
  use Ecto.Migration

  def change do
    create table(:sessions_players) do
      add :session_id, references(:sessions)
      add :player_id, references(:players)
      timestamps()
    end

    create unique_index(:sessions_players, [:session_id, :player_id])
  end
end
