defmodule Techschool.Tools.Tool do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tools" do
    field :name, :string
    field :image_url, :string
    many_to_many :courses, Techschool.Courses.Course, join_through: "courses_tools"
    many_to_many :platforms, Techschool.Platforms.Platform, join_through: "platforms_tools"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tool, attrs) do
    tool
    |> cast(attrs, [:name, :image_url])
    |> validate_required([:name, :image_url])
    |> unique_constraint(:name)
  end
end
