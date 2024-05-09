defmodule Techschool.Repo.Migrations.CreateFundamentals do
  use Ecto.Migration

  def change do
    create table(:fundamentals) do
      add :name, :string
      add :image_url, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:fundamentals, [:name])
  end
end
