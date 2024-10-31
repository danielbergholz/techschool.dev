defmodule Techschool.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  alias Techschool.Repo

  alias Techschool.{Channels, Languages, Frameworks, Tools, Fundamentals, Locale}
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

  def search_courses(params, locales_available, opts \\ []) do
    build_search_query(params, locales_available, opts)
    |> Repo.all()
    |> Enum.map(&add_course_and_channel_urls/1)
  end

  def count_courses(params, locales_available, opts \\ []) do
    opts =
      opts
      |> Keyword.put(:limit, -1)
      |> Keyword.put(:offset, 0)

    build_search_query(params, locales_available, opts)
    |> Repo.aggregate(:count, :id)
  end

  defp build_search_query do
    from course in Course,
      join: channel in assoc(course, :channel),
      preload: [channel: channel]
  end

  defp build_search_query(params, locales_available, opts) do
    search = Map.get(params, "search", "")
    language_name = Map.get(params, "language", "")
    framework_name = Map.get(params, "framework", "")
    tool_name = Map.get(params, "tool", "")
    fundamentals_name = Map.get(params, "fundamentals", "")
    user_locale = Map.get(params, "locale", Locale.get_default_locale())

    {:ok, opts} = Keyword.validate(opts, limit: 20, offset: 0)

    # Base query with channel join
    query =
      from course in Course,
        join: channel in assoc(course, :channel),
        preload: [channel: channel],
        where:
          course.locale in ^locales_available and
            (^search == "" or
               fragment("lower(?) LIKE lower(?)", course.name, ^"%#{search}%")),
        distinct: true,
        order_by: fragment("CASE WHEN locale = ? THEN 0 ELSE 1 END", ^user_locale),
        order_by: [desc: course.published_at],
        limit: ^opts[:limit],
        offset: ^opts[:offset]

    # Add joins conditionally
    query =
      if language_name != "" do
        from q in query,
          join: language in assoc(q, :languages),
          on: fragment("lower(?) LIKE lower(?)", language.name, ^"#{language_name}")
      else
        query
      end

    query =
      if framework_name != "" do
        from q in query,
          join: framework in assoc(q, :frameworks),
          on: fragment("lower(?) LIKE lower(?)", framework.name, ^"#{framework_name}")
      else
        query
      end

    query =
      if tool_name != "" do
        from q in query,
          join: tool in assoc(q, :tools),
          on: fragment("lower(?) LIKE lower(?)", tool.name, ^"#{tool_name}")
      else
        query
      end

    query =
      if fundamentals_name != "" do
        from q in query,
          join: fundamental in assoc(q, :fundamentals),
          on: fragment("lower(?) LIKE lower(?)", fundamental.name, ^"#{fundamentals_name}")
      else
        query
      end

    query
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

  def get_course_by_youtube_course_id(youtube_course_id) do
    case Repo.get_by(Course, youtube_course_id: youtube_course_id) do
      nil ->
        nil

      course ->
        course
        |> Repo.preload(:channel)
        |> add_course_and_channel_urls()
    end
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
    {:ok, opts} =
      opts
      |> Keyword.validate(
        language_names: [],
        framework_names: [],
        tool_names: [],
        fundamentals_names: []
      )

    channel = Channels.get_channel_by_youtube_channel_id(youtube_channel_id)
    languages = Languages.get_languages_by_name(opts[:language_names])
    frameworks = Frameworks.get_frameworks_by_name(opts[:framework_names])
    tools = Tools.get_tools_by_name(opts[:tool_names])
    fundamentals = Fundamentals.get_fundamentals_by_name(opts[:fundamentals_names])

    channel
    |> Ecto.build_assoc(:courses)
    |> Course.changeset(attrs,
      languages: languages,
      frameworks: frameworks,
      tools: tools,
      fundamentals: fundamentals
    )
    |> Repo.insert()
  end

  def create_course!(youtube_channel_id, attrs \\ %{}, opts \\ []) do
    {:ok, opts} =
      opts
      |> Keyword.validate(
        language_names: [],
        framework_names: [],
        tool_names: [],
        fundamentals_names: []
      )

    channel = Channels.get_channel_by_youtube_channel_id(youtube_channel_id)
    languages = Languages.get_languages_by_name(opts[:language_names])
    frameworks = Frameworks.get_frameworks_by_name(opts[:framework_names])
    tools = Tools.get_tools_by_name(opts[:tool_names])
    fundamentals = Fundamentals.get_fundamentals_by_name(opts[:fundamentals_names])

    channel
    |> Ecto.build_assoc(:courses)
    |> Course.changeset(attrs,
      languages: languages,
      frameworks: frameworks,
      tools: tools,
      fundamentals: fundamentals
    )
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
