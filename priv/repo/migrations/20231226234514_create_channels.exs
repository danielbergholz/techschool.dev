defmodule Techschool.Repo.Migrations.CreateChannels do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :name, :string
      add :image_url, :string
      add :youtube_channel_id, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:channels, [:youtube_channel_id])
  end
end
