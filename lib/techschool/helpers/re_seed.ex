defmodule Techschool.Helpers.ReSeed do
  alias Techschool.{Languages, Frameworks, Channels, Courses}

  def call(data_folder_path \\ "priv/repo/data") do
    seed_languages(data_folder_path)
    seed_frameworks(data_folder_path)
    seed_channels(data_folder_path)
    seed_courses(data_folder_path)
  end

  defp seed_languages(data_folder_path) do
    "#{data_folder_path}/languages.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_language/1)
  end

  defp insert_language(language) do
    Languages.create_language(%{
      name: language[:name],
      image_url: language[:image_url]
    })
  end

  defp seed_frameworks(data_folder_path) do
    "#{data_folder_path}/frameworks.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_framework/1)
  end

  defp insert_framework(framework) do
    Frameworks.create_framework(%{
      name: framework[:name],
      image_url: framework[:image_url]
    })
  end

  defp seed_channels(data_folder_path) do
    "#{data_folder_path}/channels.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_channel/1)
  end

  defp insert_channel(channel) do
    Channels.create_channel(%{
      name: channel[:name],
      image_url: channel[:image_url],
      youtube_channel_id: channel[:youtube_channel_id]
    })
  end

  defp seed_courses(data_folder_path) do
    "#{data_folder_path}/courses.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_course/1)
  end

  defp insert_course(course) do
    Courses.create_course(
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
