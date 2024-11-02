defmodule Techschool.Helpers.ReSeed do
  alias Techschool.{
    Languages,
    Frameworks,
    Channels,
    Courses,
    Platforms,
    Fundamentals,
    Tools,
    Bootcamps,
    Lessons,
    YouTube
  }

  def call(data_folder_path \\ "priv/repo/data") do
    Techschool.Helpers.ResetDb.call(reset_courses: false)
    seed_languages(data_folder_path)
    seed_frameworks(data_folder_path)
    seed_tools(data_folder_path)
    seed_fundamentals(data_folder_path)
    seed_lessons(data_folder_path)
    seed_bootcamps(data_folder_path)
    seed_courses_and_channels(data_folder_path)
    seed_platforms(data_folder_path)
  end

  defp seed_languages(data_folder_path) do
    "#{data_folder_path}/languages.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&Languages.create_language(&1))
  end

  defp seed_frameworks(data_folder_path) do
    "#{data_folder_path}/frameworks.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&Frameworks.create_framework(&1))
  end

  defp seed_tools(data_folder_path) do
    "#{data_folder_path}/tools.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&Tools.create_tool(&1))
  end

  defp seed_fundamentals(data_folder_path) do
    "#{data_folder_path}/fundamentals.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&Fundamentals.create_fundamental(&1))
  end

  defp seed_bootcamps(data_folder_path) do
    "#{data_folder_path}/bootcamps.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_bootcamp/1)
  end

  defp insert_bootcamp(bootcamp) do
    Bootcamps.create_bootcamp(
      bootcamp,
      lesson_names: bootcamp[:lesson_names]
    )
  end

  defp seed_lessons(data_folder_path) do
    "#{data_folder_path}/lessons.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&Lessons.create_lesson(&1))
  end

  defp seed_courses_and_channels(data_folder_path) do
    "#{data_folder_path}/courses.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&fetch_and_create_course/1)
  end

  defp fetch_and_create_course(course) do
    with nil <- Courses.get_course_by_youtube_course_id(course[:youtube_course_id]) do
      course_from_youtube =
        YouTube.fetch_course(course)

      fetch_and_create_channel(course_from_youtube["channelId"])

      formatted_course = %{
        name: course_from_youtube["title"],
        image_url: course_from_youtube["thumbnails"]["standard"]["url"],
        locale: course[:locale],
        type: course[:type],
        published_at: course_from_youtube["publishedAt"],
        youtube_course_id: course[:youtube_course_id]
      }

      Courses.create_course(
        course_from_youtube["channelId"],
        formatted_course,
        language_names: course[:language_names],
        framework_names: course[:framework_names],
        tool_names: course[:tool_names],
        fundamentals_names: course[:fundamentals_names]
      )
    end
  end

  defp fetch_and_create_channel(channel_id) do
    with nil <- Channels.get_channel_by_youtube_channel_id(channel_id) do
      channel_from_youtube = YouTube.fetch_channel(channel_id)

      formatted_channel = %{
        name: channel_from_youtube["title"],
        image_url: channel_from_youtube["thumbnails"]["default"]["url"],
        youtube_channel_id: channel_id
      }

      Channels.create_channel(formatted_channel)
    end
  end

  defp seed_platforms(data_folder_path) do
    "#{data_folder_path}/platforms.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_platform/1)
  end

  defp insert_platform(platform) do
    Platforms.create_platform(
      platform,
      language_names: platform[:language_names],
      framework_names: platform[:framework_names],
      tool_names: platform[:tool_names],
      fundamentals_names: platform[:fundamentals_names]
    )
  end
end
