defmodule Techschool.Repo.Migrations.CreateTools do
  use Ecto.Migration

  def change do
    create table(:tools) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:tools, [:name])
  end
end
