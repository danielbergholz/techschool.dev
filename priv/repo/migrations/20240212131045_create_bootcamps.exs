defmodule Techschool.Repo.Migrations.CreateBootcamps do
  use Ecto.Migration

  def change do
    create table(:bootcamps) do
      add :name, :string
      add :image_url, :string
      add :description_en, :text
      add :description_pt, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:bootcamps, [:name])
  end
end
