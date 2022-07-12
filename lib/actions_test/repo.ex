defmodule ActionsTest.Repo do
  use Ecto.Repo,
    otp_app: :actions_test,
    adapter: Ecto.Adapters.Postgres
end
