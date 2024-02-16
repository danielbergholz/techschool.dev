defmodule Techschool.Repo.Migrations.AddImageUrlToTools do
  use Ecto.Migration

  def change do
    alter table(:tools) do
      add :image_url, :string
    end
  end
end
