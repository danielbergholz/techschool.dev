defmodule Techschool.Tools.Tool do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tools" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tool, attrs) do
    tool
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
