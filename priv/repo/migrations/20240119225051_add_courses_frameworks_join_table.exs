defmodule Techschool.Repo.Migrations.AddCoursesFrameworksJoinTable do
  use Ecto.Migration

  def change do
    create table(:courses_frameworks, primary_key: false) do
      add :course_id, references(:courses, on_delete: :delete_all)
      add :framework_id, references(:frameworks, on_delete: :delete_all)
    end

    create unique_index(:courses_frameworks, [:course_id, :framework_id])
  end
end
