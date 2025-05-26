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
    field :view_count, :integer, default: 0
    belongs_to :channel, Techschool.Channels.Channel
    many_to_many :languages, Techschool.Languages.Language, join_through: "courses_languages"
    many_to_many :frameworks, Techschool.Frameworks.Framework, join_through: "courses_frameworks"
    many_to_many :tools, Techschool.Tools.Tool, join_through: "courses_tools"

    many_to_many :fundamentals, Techschool.Fundamentals.Fundamental,
      join_through: "courses_fundamentals"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(course, attrs, opts \\ []) do
    {:ok, opts} =
      opts
      |> Keyword.validate(
        languages: [],
        frameworks: [],
        tools: [],
        fundamentals: []
      )

    course
    |> cast(attrs, [
      :name,
      :image_url,
      :locale,
      :type,
      :published_at,
      :youtube_course_id,
      :channel_id,
      :view_count
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
    |> put_assoc(:languages, opts[:languages])
    |> put_assoc(:frameworks, opts[:frameworks])
    |> put_assoc(:tools, opts[:tools])
    |> put_assoc(:fundamentals, opts[:fundamentals])
  end

  @doc """
  Simple changeset for updating view count without associations.
  """
  def view_count_changeset(course, attrs) do
    course
    |> cast(attrs, [:view_count])
    |> validate_required([:view_count])
  end
end
