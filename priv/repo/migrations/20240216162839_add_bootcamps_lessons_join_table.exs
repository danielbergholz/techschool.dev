defmodule Techschool.Repo.Migrations.AddBootcampsLessonsJoinTable do
  use Ecto.Migration

  def change do
    create table(:bootcamps_lessons, primary_key: false) do
      add :bootcamp_id, references(:bootcamps, on_delete: :delete_all)
      add :lesson_id, references(:lessons, on_delete: :delete_all)
    end

    create unique_index(:bootcamps_lessons, [:bootcamp_id, :lesson_id])
  end
end
