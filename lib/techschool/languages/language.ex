defmodule Techschool.Languages.Language do
  use Ecto.Schema
  import Ecto.Changeset

  schema "languages" do
    field :name, :string
    field :image_url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(language, attrs) do
    language
    |> cast(attrs, [:name, :image_url])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
