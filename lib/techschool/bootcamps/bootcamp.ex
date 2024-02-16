defmodule Techschool.Bootcamps.Bootcamp do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bootcamps" do
    field :name, :string
    field :image_url, :string
    field :description_en, :string
    field :description_pt, :string
    many_to_many :lessons, Techschool.Lessons.Lesson, join_through: "bootcamps_lessons"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bootcamp, attrs, opts \\ []) do
    lessons = Keyword.get(opts, :lessons, [])

    bootcamp
    |> cast(attrs, [:name, :image_url, :description_en, :description_pt])
    |> validate_required([:name, :image_url, :description_en, :description_pt])
    |> unique_constraint(:name)
    |> put_assoc(:lessons, lessons)
  end
end
