defmodule Techschool.LanguagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Techschool.Languages` context.
  """

  @doc """
  Generate a unique language name.
  """
  def unique_language_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a language.
  """
  def language_fixture(attrs \\ %{}) do
    {:ok, language} =
      attrs
      |> Enum.into(%{
        icon_name: "some icon_name",
        name: unique_language_name()
      })
      |> Techschool.Languages.create_language()

    language
  end
end
