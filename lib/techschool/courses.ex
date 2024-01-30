defmodule Techschool.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  alias Techschool.Repo

  alias Techschool.Courses.Course
  alias Techschool.Channels
  alias Techschool.Languages
  alias Techschool.Frameworks

  @doc """
  Returns the list of courses.

  ## Examples

      iex> list_courses()
      [%Course{}, ...]

  """
  def list_courses() do
    build_search_query()
    |> Repo.all()
    |> Enum.map(&add_course_and_channel_urls/1)
  end

  def search_courses(params, locale) do
    build_search_query(params, locale)
    |> Repo.all()
    |> Enum.map(&add_course_and_channel_urls/1)
  end

  defp build_search_query do
    from course in Course,
      preload: [:channel]
  end

  defp build_search_query(
         %{"search" => search, "language" => language_name, "framework" => framework_name},
         locale
       ) do
    from course in Course,
      left_join: language in assoc(course, :languages),
      left_join: framework in assoc(course, :frameworks),
      where:
        course.locale in ^locale and
          (^is_nil_or_empty(search) or
             fragment("lower(?) LIKE lower(?)", course.name, ^"%#{search}%")) and
          (^is_nil_or_empty(language_name) or
             fragment("lower(?) LIKE lower(?)", language.name, ^"%#{language_name}%")) and
          (^is_nil_or_empty(framework_name) or
             fragment("lower(?) LIKE lower(?)", framework.name, ^"%#{framework_name}%")),
      preload: [:channel]
  end

  defp build_search_query(_, locale) do
    from course in Course,
      where: course.locale in ^locale,
      preload: [:channel]
  end

  defp is_nil_or_empty(value), do: value in ["", nil]

  @doc """
  Gets a single course.

  Raises `Ecto.NoResultsError` if the Course does not exist.

  ## Examples

      iex> get_course!(123)
      %Course{}

      iex> get_course!(456)
      ** (Ecto.NoResultsError)

  """
  def get_course!(id) do
    Repo.get!(Course, id)
    |> Repo.preload(:channel)
    |> add_course_and_channel_urls()
  end

  @doc """
  Creates a course and associates it with a channel.

  ## Examples

      iex> create_course(%{field: value})
      {:ok, %Course{}}

      iex> create_course(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_course(attrs \\ %{}, youtube_channel_id, language_names \\ [], framework_names \\ []) do
    channel = Channels.get_channel_by_youtube_channel_id(youtube_channel_id)
    languages = Languages.get_languages_by_name(language_names)
    frameworks = Frameworks.get_frameworks_by_name(framework_names)

    channel
    |> Ecto.build_assoc(:courses)
    |> Course.changeset(attrs, languages, frameworks)
    |> Repo.insert()
  end

  def create_course!(
        attrs \\ %{},
        youtube_channel_id,
        language_names \\ [],
        framework_names \\ []
      ) do
    channel = Channels.get_channel_by_youtube_channel_id(youtube_channel_id)
    languages = Languages.get_languages_by_name(language_names)
    frameworks = Frameworks.get_frameworks_by_name(framework_names)

    channel
    |> Ecto.build_assoc(:courses)
    |> Course.changeset(attrs, languages, frameworks)
    |> Repo.insert!()
  end

  @doc """
  Deletes a course.

  ## Examples

      iex> delete_course(course)
      {:ok, %Course{}}

      iex> delete_course(course)
      {:error, %Ecto.Changeset{}}

  """
  def delete_course(%Course{} = course) do
    Repo.delete(course)
  end

  defp add_course_and_channel_urls(%Course{} = course) do
    course
    |> Map.put(:url, generate_url(course))
    |> Map.put(:channel, Channels.add_channel_url(course.channel))
  end

  defp generate_url(%Course{type: :video} = course) do
    "https://www.youtube.com/video/#{course.youtube_course_id}"
  end

  defp generate_url(%Course{type: :playlist} = course) do
    "https://www.youtube.com/playlist?list=#{course.youtube_course_id}"
  end
end
