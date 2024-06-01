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
    language_names = Keyword.get(opts, :language_names, [])
    framework_names = Keyword.get(opts, :framework_names, [])
    tool_names = Keyword.get(opts, :tool_names, [])
    fundamentals_names = Keyword.get(opts, :fundamentals_names, [])

    languages = Languages.get_languages_by_name(language_names)
    frameworks = Frameworks.get_frameworks_by_name(framework_names)
    tools = Tools.get_tools_by_name(tool_names)
    fundamentals = Fundamentals.get_fundamentals_by_name(fundamentals_names)

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
    language_names = Keyword.get(opts, :language_names, [])
    framework_names = Keyword.get(opts, :framework_names, [])
    tool_names = Keyword.get(opts, :tool_names, [])
    fundamentals_names = Keyword.get(opts, :fundamentals_names, [])

    languages = Languages.get_languages_by_name(language_names)
    frameworks = Frameworks.get_frameworks_by_name(framework_names)
    tools = Tools.get_tools_by_name(tool_names)
    fundamentals = Fundamentals.get_fundamentals_by_name(fundamentals_names)

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
