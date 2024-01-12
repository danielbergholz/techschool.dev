defmodule Techschool.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :name, :string
    field :url, :string, virtual: true
    field :type, Ecto.Enum, values: [:video, :playlist]
    field :locale, Ecto.Enum, values: [:en, :pt]
    field :image_url, :string
    field :published_at, :utc_datetime
    field :youtube_course_id, :string
    belongs_to :channel, Techschool.Channels.Channel

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [
      :name,
      :image_url,
      :locale,
      :type,
      :published_at,
      :youtube_course_id,
      :channel_id
    ])
    |> validate_required([
      :name,
      :image_url,
      :locale,
      :type,
      :published_at,
      :youtube_course_id,
      :channel_id
    ])
    |> foreign_key_constraint(:channel_id)
    |> unique_constraint(:youtube_course_id)
  end
end
