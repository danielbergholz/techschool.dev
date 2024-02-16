defmodule Techschool.Bootcamps do
  @moduledoc """
  The Bootcamps context.
  """

  import Ecto.Query, warn: false
  alias Techschool.Repo

  alias Techschool.Bootcamps.Bootcamp
  alias Techschool.Lessons

  @doc """
  Returns the list of bootcamps.

  ## Examples

      iex> list_bootcamps()
      [%Bootcamp{}, ...]

  """
  def list_bootcamps do
    Repo.all(Bootcamp)
  end

  @doc """
  Gets a single bootcamp.

  Raises `Ecto.NoResultsError` if the Bootcamp does not exist.

  ## Examples

      iex> get_bootcamp!(123)
      %Bootcamp{}

      iex> get_bootcamp!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bootcamp!(id), do: Repo.get!(Bootcamp, id)

  @doc """
  Creates a bootcamp.

  ## Examples

      iex> create_bootcamp(%{field: value})
      {:ok, %Bootcamp{}}

      iex> create_bootcamp(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bootcamp(attrs \\ %{}, opts \\ []) do
    lesson_names = Keyword.get(opts, :lesson_names, [])
    lessons = Lessons.get_lessons_by_name(lesson_names)

    %Bootcamp{}
    |> Bootcamp.changeset(attrs, lessons: lessons)
    |> Repo.insert()
  end

  def create_bootcamp!(attrs \\ %{}, opts \\ []) do
    lesson_names = Keyword.get(opts, :lesson_names, [])
    lessons = Lessons.get_lessons_by_name(lesson_names)

    %Bootcamp{}
    |> Bootcamp.changeset(attrs, lessons: lessons)
    |> Repo.insert!()
  end

  @doc """
  Deletes a bootcamp.

  ## Examples

      iex> delete_bootcamp(bootcamp)
      {:ok, %Bootcamp{}}

      iex> delete_bootcamp(bootcamp)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bootcamp(%Bootcamp{} = bootcamp) do
    Repo.delete(bootcamp)
  end
end
