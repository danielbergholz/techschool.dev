defmodule Techschool.Repo.Migrations.AddCoursesToolsJoinTable do
  use Ecto.Migration

  def change do
    create table(:courses_tools, primary_key: false) do
      add :course_id, references(:courses, on_delete: :delete_all)
      add :tool_id, references(:tools, on_delete: :delete_all)
    end

    create unique_index(:courses_tools, [:course_id, :tool_id])
  end
end
