defmodule SJCCHoops.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :email, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:players, [:email])
  end
end
