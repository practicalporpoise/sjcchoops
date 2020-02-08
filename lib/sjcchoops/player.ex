defmodule SJCCHoops.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :email, :string
    field :name, :string
    field :active, :boolean, default: false

    timestamps()

    many_to_many :sessions, SJCCHoops.Session, join_through: "sessions_players"
  end

  @doc false
  def changeset(player, attrs \\ %{}) do
    player
    |> cast(attrs, [:name, :email, :active])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end
end
