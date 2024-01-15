defmodule Techschool.Helpers.ResetDb do
  alias Techschool.Repo

  def call do
    # List all your Ecto schemas here
    tables = [
      Techschool.Languages.Language,
      Techschool.Frameworks.Framework,
      Techschool.Channels.Channel,
      Techschool.Courses.Course
    ]

    Enum.each(tables, &Repo.delete_all/1)
  end
end
