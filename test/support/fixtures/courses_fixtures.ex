defmodule Techschool.CoursesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Techschool.Courses` context.
  """

  @doc """
  Generate a unique course youtube_course_id.
  """
  def unique_course_youtube_course_id,
    do: "youtube_course_id#{System.unique_integer([:positive])}"

  @doc """
  Generate a course.
  """
  def course_fixture(attrs \\ %{}, youtube_channel_id) do
    {:ok, course} =
      attrs
      |> Enum.into(%{
        youtube_course_id: unique_course_youtube_course_id(),
        image_url: "some image_url",
        locale: :en,
        name: "some name",
        published_at: ~U[2024-01-05 17:44:00Z],
        type: :video
      })
      |> Techschool.Courses.create_course(youtube_channel_id)

    Techschool.Courses.get_course!(course.id)
  end
end
