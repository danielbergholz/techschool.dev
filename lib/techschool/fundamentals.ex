defmodule Techschool.Fundamentals do
  @moduledoc """
  The Fundamentals context.
  """

  import Ecto.Query, warn: false
  alias Techschool.Repo

  alias Techschool.Fundamentals.Fundamental

  @doc """
  Returns the list of fundamentals.

  ## Examples

      iex> list_fundamentals()
      [%Fundamental{}, ...]

  """
  def list_fundamentals do
    Repo.all(Fundamental)
  end

  def list_fundamentals_names do
    Repo.all(from fundamental in Fundamental, select: fundamental.name)
  end

  @doc """
  Gets a single fundamental.

  Raises `Ecto.NoResultsError` if the Fundamental does not exist.

  ## Examples

      iex> get_fundamental!(123)
      %Fundamental{}

      iex> get_fundamental!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fundamental!(id), do: Repo.get!(Fundamental, id)

  def get_fundamentals_by_name([]), do: []

  def get_fundamentals_by_name(names) do
    Repo.all(from fundamental in Fundamental, where: fundamental.name in ^names)
  end

  @doc """
  Creates a fundamental.

  ## Examples

      iex> create_fundamental(%{field: value})
      {:ok, %Fundamental{}}

      iex> create_fundamental(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fundamental(attrs \\ %{}) do
    %Fundamental{}
    |> Fundamental.changeset(attrs)
    |> Repo.insert()
  end

  def create_fundamental!(attrs \\ %{}) do
    %Fundamental{}
    |> Fundamental.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Deletes a fundamental.

  ## Examples

      iex> delete_fundamental(fundamental)
      {:ok, %Fundamental{}}

      iex> delete_fundamental(fundamental)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fundamental(%Fundamental{} = fundamental) do
    Repo.delete(fundamental)
  end
end
