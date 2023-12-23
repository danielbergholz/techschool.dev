defmodule Techschool.Frameworks do
  @moduledoc """
  The Frameworks context.
  """

  import Ecto.Query, warn: false
  alias Techschool.Repo

  alias Techschool.Frameworks.Framework

  @doc """
  Returns the list of frameworks.

  ## Examples

      iex> list_frameworks()
      [%Framework{}, ...]

  """
  def list_frameworks do
    Repo.all(Framework)
  end

  @doc """
  Gets a single framework.

  Raises `Ecto.NoResultsError` if the Framework does not exist.

  ## Examples

      iex> get_framework!(123)
      %Framework{}

      iex> get_framework!(456)
      ** (Ecto.NoResultsError)

  """
  def get_framework!(id), do: Repo.get!(Framework, id)

  @doc """
  Creates a framework.

  ## Examples

      iex> create_framework(%{field: value})
      {:ok, %Framework{}}

      iex> create_framework(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_framework(attrs \\ %{}) do
    %Framework{}
    |> Framework.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a framework.

  Raises `Ecto.InvalidChangesetError` for invalid framework.

  ## Examples

      iex> create_framework!(%{field: value})
      %Framework{}

      iex> create_framework!(%{field: bad_value})
      ** (Ecto.InvalidChangesetError)

  """
  def create_framework!(attrs \\ %{}) do
    %Framework{}
    |> Framework.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a framework.

  ## Examples

      iex> update_framework(framework, %{field: new_value})
      {:ok, %Framework{}}

      iex> update_framework(framework, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_framework(%Framework{} = framework, attrs) do
    framework
    |> Framework.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a framework.

  ## Examples

      iex> delete_framework(framework)
      {:ok, %Framework{}}

      iex> delete_framework(framework)
      {:error, %Ecto.Changeset{}}

  """
  def delete_framework(%Framework{} = framework) do
    Repo.delete(framework)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking framework changes.

  ## Examples

      iex> change_framework(framework)
      %Ecto.Changeset{data: %Framework{}}

  """
  def change_framework(%Framework{} = framework, attrs \\ %{}) do
    Framework.changeset(framework, attrs)
  end
end
