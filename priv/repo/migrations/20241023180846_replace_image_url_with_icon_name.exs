defmodule Techschool.Repo.Migrations.ReplaceImageUrlWithIconName do
  use Ecto.Migration

  def change do
    alter table(:bootcamps) do
      add :icon_name, :string
      remove :image_url
    end

    alter table(:frameworks) do
      add :icon_name, :string
      remove :image_url
    end

    alter table(:fundamentals) do
      add :icon_name, :string
      remove :image_url
    end

    alter table(:languages) do
      add :icon_name, :string
      remove :image_url
    end

    alter table(:lessons) do
      add :icon_name, :string
      remove :image_url
    end

    alter table(:tools) do
      add :icon_name, :string
      remove :image_url
    end
  end
end
