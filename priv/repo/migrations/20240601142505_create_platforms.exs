defmodule Techschool.Repo.Migrations.CreatePlatforms do
  use Ecto.Migration

  def change do
    create table(:platforms) do
      add :name, :string
      add :description_en, :string
      add :description_pt, :string
      add :image_url, :string
      add :url, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:platforms, [:name])
  end
end
