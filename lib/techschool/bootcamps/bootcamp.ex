defmodule Techschool.Bootcamps.Bootcamp do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bootcamps" do
    field :name, :string
    field :image_url, :string
    field :description_en, :string
    field :description_pt, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bootcamp, attrs) do
    bootcamp
    |> cast(attrs, [:name, :image_url, :description_en, :description_pt])
    |> validate_required([:name, :image_url, :description_en, :description_pt])
    |> unique_constraint(:name)
  end
end
