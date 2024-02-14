defmodule Techschool.Repo.Migrations.CreateLessons do
  use Ecto.Migration

  def change do
    create table(:lessons) do
      add :name, :string
      add :image_url, :string
      add :optional, :boolean, default: false, null: false
      add :description_en, :text
      add :description_pt, :text
      add :language_names, :string
      add :framework_names, :string
      add :tool_names, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:lessons, [:name])
  end
end
