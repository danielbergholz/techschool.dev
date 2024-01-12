defmodule Techschool.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :string
      add :image_url, :string
      add :locale, :string
      add :type, :string
      add :published_at, :utc_datetime
      add :youtube_course_id, :string
      add :channel_id, references(:channels, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:courses, [:youtube_course_id])
    create index(:courses, [:channel_id])
  end
end
