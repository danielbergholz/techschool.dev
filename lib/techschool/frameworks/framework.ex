defmodule Techschool.Frameworks.Framework do
  use Ecto.Schema
  import Ecto.Changeset

  schema "frameworks" do
    field :name, :string
    field :image_url, :string
    many_to_many :courses, Techschool.Courses.Course, join_through: "courses_frameworks"
    many_to_many :platforms, Techschool.Platforms.Platform, join_through: "platforms_frameworks"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(framework, attrs) do
    framework
    |> cast(attrs, [:name, :image_url])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
