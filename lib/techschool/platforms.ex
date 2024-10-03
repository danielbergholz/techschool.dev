defmodule Techschool.Platforms do
  @moduledoc """
  The Platforms context.
  """

  import Ecto.Query, warn: false
  alias Techschool.Repo

  alias Techschool.{Languages, Frameworks, Tools, Fundamentals}
  alias Techschool.Platforms.Platform

  @doc """
  Returns the list of platforms.

  ## Examples

      iex> list_platforms()
      [%Platform{}, ...]

  """
  def list_platforms do
    Repo.all(Platform)
  end

  def search_platforms, do: list_platforms()

  def search_platforms(params) do
    search = Map.get(params, "search", "")
    language_name = Map.get(params, "language", "")
    framework_name = Map.get(params, "framework", "")
    tool_name = Map.get(params, "tool", "")
    fundamentals_name = Map.get(params, "fundamentals", "")

    # Base query
    query =
      from platform in Platform,
        where:
          ^search == "" or
            fragment("lower(?) LIKE lower(?)", platform.name, ^"%#{search}%"),
        order_by: [asc: platform.inserted_at],
        distinct: true

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
    |> Repo.all()
  end

  @doc """
  Gets a single platform.

  Raises `Ecto.NoResultsError` if the Platform does not exist.

  ## Examples

      iex> get_platform!(123)
      %Platform{}

      iex> get_platform!(456)
      ** (Ecto.NoResultsError)

  """
  def get_platform!(id), do: Repo.get!(Platform, id)

  @doc """
  Creates a platform.

  ## Examples

      iex> create_platform(%{field: value})
      {:ok, %Platform{}}

      iex> create_platform(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_platform(attrs \\ %{}, opts \\ []) do
    {:ok, opts} =
      opts
      |> Keyword.validate(
        language_names: [],
        framework_names: [],
        tool_names: [],
        fundamentals_names: []
      )

    languages = Languages.get_languages_by_name(opts[:language_names])
    frameworks = Frameworks.get_frameworks_by_name(opts[:framework_names])
    tools = Tools.get_tools_by_name(opts[:tool_names])
    fundamentals = Fundamentals.get_fundamentals_by_name(opts[:fundamentals_names])

    %Platform{}
    |> Platform.changeset(attrs,
      languages: languages,
      frameworks: frameworks,
      tools: tools,
      fundamentals: fundamentals
    )
    |> Repo.insert()
  end

  def create_platform!(attrs \\ %{}, opts \\ []) do
    {:ok, opts} =
      opts
      |> Keyword.validate(
        language_names: [],
        framework_names: [],
        tool_names: [],
        fundamentals_names: []
      )

    languages = Languages.get_languages_by_name(opts[:language_names])
    frameworks = Frameworks.get_frameworks_by_name(opts[:framework_names])
    tools = Tools.get_tools_by_name(opts[:tool_names])
    fundamentals = Fundamentals.get_fundamentals_by_name(opts[:fundamentals_names])

    %Platform{}
    |> Platform.changeset(attrs,
      languages: languages,
      frameworks: frameworks,
      tools: tools,
      fundamentals: fundamentals
    )
    |> Repo.insert!()
  end

  @doc """
  Deletes a platform.

  ## Examples

      iex> delete_platform(platform)
      {:ok, %Platform{}}

      iex> delete_platform(platform)
      {:error, %Ecto.Changeset{}}

  """
  def delete_platform(%Platform{} = platform) do
    Repo.delete(platform)
  end
end
