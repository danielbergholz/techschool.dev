defmodule Techschool.Platforms.Platform do
  use Ecto.Schema
  import Ecto.Changeset

  schema "platforms" do
    field :name, :string
    field :url, :string
    field :description_en, :string
    field :description_pt, :string
    field :image_url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(platform, attrs) do
    platform
    |> cast(attrs, [:name, :description_en, :description_pt, :image_url, :url])
    |> validate_required([:name, :description_en, :description_pt, :image_url, :url])
    |> unique_constraint(:name)
  end
end
