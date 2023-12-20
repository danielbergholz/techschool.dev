defmodule Techschool.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :name, :string
      add :image_url, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:languages, [:name])
  end
end
