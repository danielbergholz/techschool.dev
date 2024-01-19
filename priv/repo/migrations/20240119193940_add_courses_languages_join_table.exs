defmodule Techschool.Repo.Migrations.AddCoursesLanguagesJoinTable do
  use Ecto.Migration

  def change do
    create table(:courses_languages, primary_key: false) do
      add :course_id, references(:courses, on_delete: :delete_all)
      add :language_id, references(:languages, on_delete: :delete_all)
    end

    create unique_index(:courses_languages, [:course_id, :language_id])
  end
end
