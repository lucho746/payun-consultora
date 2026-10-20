defmodule Consultora.Repo do
  use Ecto.Repo,
    otp_app: :consultora,
    adapter: Ecto.Adapters.Postgres
end
