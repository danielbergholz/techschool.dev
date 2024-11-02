defmodule Techschool.Helpers.ResetDb do
  alias Techschool.Repo

  def call, do: call(reset_courses: true)

  def call(opts) do
    reset_courses = Keyword.get(opts, :reset_courses, false)

    tables = [
      Techschool.Languages.Language,
      Techschool.Frameworks.Framework,
      Techschool.Tools.Tool,
      Techschool.Fundamentals.Fundamental,
      Techschool.Lessons.Lesson,
      Techschool.Bootcamps.Bootcamp,
      Techschool.Platforms.Platform
    ]

    tables =
      if reset_courses do
        tables ++
          [
            Techschool.Courses.Course,
            Techschool.Channels.Channel
          ]
      else
        tables
      end

    Enum.each(tables, &Repo.delete_all/1)
  end
end
