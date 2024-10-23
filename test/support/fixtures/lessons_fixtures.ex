defmodule Techschool.LessonsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Techschool.Lessons` context.
  """

  @doc """
  Generate a unique lesson name.
  """
  def unique_lesson_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a lesson.
  """
  def lesson_fixture(attrs \\ %{}) do
    {:ok, lesson} =
      attrs
      |> Enum.into(%{
        description_en: "some description_en",
        description_pt: "some description_pt",
        framework_names: "some framework_names",
        icon_name: "some icon_name",
        language_names: "some language_names",
        name: unique_lesson_name(),
        optional: true,
        tool_names: "some tool_names"
      })
      |> Techschool.Lessons.create_lesson()

    lesson
  end
end
