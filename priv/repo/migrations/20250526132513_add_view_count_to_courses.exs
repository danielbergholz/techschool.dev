defmodule Techschool.Repo.Migrations.AddViewCountToCourses do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      add :view_count, :integer, default: 0, null: false
    end
  end
end
