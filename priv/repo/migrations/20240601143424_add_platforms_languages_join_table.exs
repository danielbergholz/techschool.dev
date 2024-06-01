defmodule Techschool.Repo.Migrations.AddPlatformsLanguagesJoinTable do
  use Ecto.Migration

  def change do
    create table(:platforms_languages, primary_key: false) do
      add :platform_id, references(:platforms, on_delete: :delete_all)
      add :language_id, references(:languages, on_delete: :delete_all)
    end

    create unique_index(:platforms_languages, [:platform_id, :language_id])
  end
end
