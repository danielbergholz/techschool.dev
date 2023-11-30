defmodule Techschool.Repo do
  use Ecto.Repo,
    otp_app: :techschool,
    adapter: Ecto.Adapters.SQLite3
end
