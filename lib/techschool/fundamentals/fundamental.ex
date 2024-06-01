defmodule Techschool.Fundamentals.Fundamental do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fundamentals" do
    field :name, :string
    field :image_url, :string
    many_to_many :courses, Techschool.Courses.Course, join_through: "courses_fundamentals"
    many_to_many :platforms, Techschool.Platforms.Platform, join_through: "platforms_fundamentals"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(fundamental, attrs) do
    fundamental
    |> cast(attrs, [:name, :image_url])
    |> validate_required([:name, :image_url])
    |> unique_constraint(:name)
  end
end
