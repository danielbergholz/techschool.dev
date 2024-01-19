defmodule Techschool.Languages do
  @moduledoc """
  The Languages context.
  """

  import Ecto.Query, warn: false
  alias Techschool.Repo

  alias Techschool.Languages.Language

  @doc """
  Returns the list of languages.

  ## Examples

      iex> list_languages()
      [%Language{}, ...]

  """
  def list_languages do
    Repo.all(Language)
  end

  @doc """
  Gets a single language.

  Raises `Ecto.NoResultsError` if the Language does not exist.

  ## Examples

      iex> get_language!(123)
      %Language{}

      iex> get_language!(456)
      ** (Ecto.NoResultsError)

  """
  def get_language!(id), do: Repo.get!(Language, id)

  def get_language_by_name(name) do
    Repo.get_by(Language, name: name)
  end

  @doc """
  Creates a language.

  ## Examples

      iex> create_language(%{field: value})
      {:ok, %Language{}}

      iex> create_language(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_language(attrs \\ %{}) do
    %Language{}
    |> Language.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a language.

  Raises `Ecto.InvalidChangesetError` for invalid language.

  ## Examples

      iex> create_language!(%{field: value})
      %Language{}

      iex> create_language!(%{field: bad_value})
      ** (Ecto.InvalidChangesetError)

  """
  def create_language!(attrs \\ %{}) do
    %Language{}
    |> Language.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Deletes a language.

  ## Examples

      iex> delete_language(language)
      {:ok, %Language{}}

      iex> delete_language(language)
      {:error, %Ecto.Changeset{}}

  """
  def delete_language(%Language{} = language) do
    Repo.delete(language)
  end
end
