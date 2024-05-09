defmodule Techschool.Repo.Migrations.AddCoursesFundamentalsJoinTable do
  use Ecto.Migration

  def change do
    create table(:courses_fundamentals, primary_key: false) do
      add :course_id, references(:courses, on_delete: :delete_all)
      add :fundamental_id, references(:fundamentals, on_delete: :delete_all)
    end

    create unique_index(:courses_fundamentals, [:course_id, :fundamental_id])
  end
end
