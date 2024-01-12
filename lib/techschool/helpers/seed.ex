defmodule Techschool.Helpers.Seed do
  alias Techschool.{Languages, Frameworks, Channels, Courses}

  def call() do
    seed_languages()
    seed_frameworks()
    seed_channels()
    seed_courses()
  end

  defp seed_languages() do
    "priv/repo/data/languages.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_language/1)
  end

  defp insert_language(language) do
    Languages.create_language!(%{
      name: language[:name],
      image_url: language[:image_url]
    })
  end

  defp seed_frameworks() do
    "priv/repo/data/frameworks.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_framework/1)
  end

  defp insert_framework(framework) do
    Frameworks.create_framework!(%{
      name: framework[:name],
      image_url: framework[:image_url]
    })
  end

  defp seed_channels() do
    "priv/repo/data/channels.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_channel/1)
  end

  defp insert_channel(channel) do
    Channels.create_channel!(%{
      name: channel[:name],
      image_url: channel[:image_url],
      youtube_channel_id: channel[:youtube_channel_id]
    })
  end

  defp seed_courses() do
    "priv/repo/data/courses.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_course/1)
  end

  defp insert_course(course) do
    Courses.create_course!(
      %{
        name: course[:name],
        type: course[:type],
        locale: course[:locale],
        image_url: course[:image_url],
        published_at: course[:published_at],
        youtube_course_id: course[:youtube_course_id]
      },
      course[:youtube_channel_id]
    )
  end
end
