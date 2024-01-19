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

  def get_framework_by_name(name) do
    Repo.get_by(Framework, name: name)
  end

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
end
