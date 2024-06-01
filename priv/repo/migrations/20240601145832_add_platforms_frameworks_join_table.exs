defmodule Techschool.Repo.Migrations.AddPlatformsFrameworksJoinTable do
  use Ecto.Migration

  def change do
    create table(:platforms_frameworks, primary_key: false) do
      add :platform_id, references(:platforms, on_delete: :delete_all)
      add :framework_id, references(:frameworks, on_delete: :delete_all)
    end

    create unique_index(:platforms_frameworks, [:platform_id, :framework_id])
  end
end
