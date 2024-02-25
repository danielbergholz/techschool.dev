defmodule Techschool.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  alias Techschool.Repo

  alias Techschool.{Channels, Languages, Frameworks, Tools}
  alias Techschool.Courses.Course

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

  def search_courses(params, locale, opts \\ []) do
    build_search_query(params, locale, opts)
    |> Repo.all()
    |> Enum.map(&add_course_and_channel_urls/1)
  end

  defp build_search_query do
    from course in Course,
      preload: [:channel]
  end

  defp build_search_query(params, locale, opts) do
    search = Map.get(params, "search", "")
    language_name = Map.get(params, "language", "")
    framework_name = Map.get(params, "framework", "")
    tool_name = Map.get(params, "tool", "")
    limit = Keyword.get(opts, :limit, 20)
    offset = Keyword.get(opts, :offset, 0)

    from course in Course,
      left_join: language in assoc(course, :languages),
      left_join: framework in assoc(course, :frameworks),
      left_join: tool in assoc(course, :tools),
      where:
        course.locale in ^locale and
          (^search == "" or
             fragment("lower(?) LIKE lower(?)", course.name, ^"%#{search}%")) and
          (^language_name == "" or
             fragment("lower(?) LIKE lower(?)", language.name, ^"#{language_name}")) and
          (^framework_name == "" or
             fragment("lower(?) LIKE lower(?)", framework.name, ^"#{framework_name}")) and
          (^tool_name == "" or
             fragment("lower(?) LIKE lower(?)", tool.name, ^"#{tool_name}")),
      preload: [:channel],
      distinct: true,
      order_by: [desc: course.published_at],
      limit: ^limit,
      offset: ^offset
  end

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
  def create_course(youtube_channel_id, attrs \\ %{}, opts \\ []) do
    language_names = Keyword.get(opts, :language_names, [])
    framework_names = Keyword.get(opts, :framework_names, [])
    tool_names = Keyword.get(opts, :tool_names, [])

    channel = Channels.get_channel_by_youtube_channel_id(youtube_channel_id)
    languages = Languages.get_languages_by_name(language_names)
    frameworks = Frameworks.get_frameworks_by_name(framework_names)
    tools = Tools.get_tools_by_name(tool_names)

    channel
    |> Ecto.build_assoc(:courses)
    |> Course.changeset(attrs, languages: languages, frameworks: frameworks, tools: tools)
    |> Repo.insert()
  end

  def create_course!(youtube_channel_id, attrs \\ %{}, opts \\ []) do
    language_names = Keyword.get(opts, :language_names, [])
    framework_names = Keyword.get(opts, :framework_names, [])
    tool_names = Keyword.get(opts, :tool_names, [])

    channel = Channels.get_channel_by_youtube_channel_id(youtube_channel_id)
    languages = Languages.get_languages_by_name(language_names)
    frameworks = Frameworks.get_frameworks_by_name(framework_names)
    tools = Tools.get_tools_by_name(tool_names)

    channel
    |> Ecto.build_assoc(:courses)
    |> Course.changeset(attrs, languages: languages, frameworks: frameworks, tools: tools)
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
