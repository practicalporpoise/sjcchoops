defmodule SJCCHoops.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :date, :date

    timestamps()

    many_to_many :players, SJCCHoops.Player, join_through: "sessions_players"
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:date])
    |> validate_required([:date])
    |> unique_constraint(:date)
  end
end
