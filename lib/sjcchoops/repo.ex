defmodule SJCCHoops.Repo do
  use Ecto.Repo,
    otp_app: :sjcchoops,
    adapter: Ecto.Adapters.Postgres
end
