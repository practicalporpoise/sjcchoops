defmodule SJCCHoops.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :date, :date

      timestamps()
    end

    create unique_index(:sessions, [:date])
  end
end
