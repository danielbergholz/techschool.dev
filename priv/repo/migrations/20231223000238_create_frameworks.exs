defmodule Techschool.Repo.Migrations.CreateFrameworks do
  use Ecto.Migration

  def change do
    create table(:frameworks) do
      add :name, :string
      add :image_url, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:frameworks, [:name])
  end
end
