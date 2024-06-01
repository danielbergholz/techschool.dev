defmodule Techschool.Platforms.Platform do
  use Ecto.Schema
  import Ecto.Changeset

  schema "platforms" do
    field :name, :string
    field :url, :string
    field :description_en, :string
    field :description_pt, :string
    field :image_url, :string

    many_to_many :languages, Techschool.Languages.Language, join_through: "platforms_languages"

    many_to_many :frameworks, Techschool.Frameworks.Framework,
      join_through: "platforms_frameworks"

    many_to_many :tools, Techschool.Tools.Tool, join_through: "platforms_tools"

    many_to_many :fundamentals, Techschool.Fundamentals.Fundamental,
      join_through: "platforms_fundamentals"

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
