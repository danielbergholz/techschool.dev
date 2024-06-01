defmodule Techschool.Repo.Migrations.AddPlatformsToolsJoinTable do
  use Ecto.Migration

  def change do
    create table(:platforms_tools, primary_key: false) do
      add :platform_id, references(:platforms, on_delete: :delete_all)
      add :tool_id, references(:tools, on_delete: :delete_all)
    end

    create unique_index(:platforms_tools, [:platform_id, :tool_id])
  end
end
