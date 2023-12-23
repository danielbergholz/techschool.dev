defmodule Techschool.Frameworks.Framework do
  use Ecto.Schema
  import Ecto.Changeset

  schema "frameworks" do
    field :name, :string
    field :image_url, :string

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
