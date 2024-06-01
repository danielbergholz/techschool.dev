defmodule Techschool.Repo.Migrations.AddPlatformsFundamentalsJoinTable do
  use Ecto.Migration

  def change do
    create table(:platforms_fundamentals, primary_key: false) do
      add :platform_id, references(:platforms, on_delete: :delete_all)
      add :fundamental_id, references(:fundamentals, on_delete: :delete_all)
    end

    create unique_index(:platforms_fundamentals, [:platform_id, :fundamental_id])
  end
end
