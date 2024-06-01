defmodule Techschool.Helpers.Seed do
  alias Techschool.{
    Languages,
    Frameworks,
    Channels,
    Courses,
    Platforms,
    Tools,
    Fundamentals,
    Bootcamps,
    Lessons
  }

  def call(data_folder_path \\ "priv/repo/data") do
    Techschool.Helpers.ResetDb.call()
    seed_languages(data_folder_path)
    seed_frameworks(data_folder_path)
    seed_tools(data_folder_path)
    seed_fundamentals(data_folder_path)
    seed_lessons(data_folder_path)
    seed_bootcamps(data_folder_path)
    seed_channels(data_folder_path)
    seed_courses(data_folder_path)
    seed_platforms(data_folder_path)
  end

  defp seed_languages(data_folder_path) do
    "#{data_folder_path}/languages.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&Languages.create_language!(&1))
  end

  defp seed_frameworks(data_folder_path) do
    "#{data_folder_path}/frameworks.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&Frameworks.create_framework!(&1))
  end

  defp seed_tools(data_folder_path) do
    "#{data_folder_path}/tools.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&Tools.create_tool!(&1))
  end

  defp seed_fundamentals(data_folder_path) do
    "#{data_folder_path}/fundamentals.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&Fundamentals.create_fundamental!(&1))
  end

  defp seed_bootcamps(data_folder_path) do
    "#{data_folder_path}/bootcamps.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_bootcamp/1)
  end

  defp insert_bootcamp(bootcamp) do
    Bootcamps.create_bootcamp!(
      bootcamp,
      lesson_names: bootcamp[:lesson_names]
    )
  end

  defp seed_lessons(data_folder_path) do
    "#{data_folder_path}/lessons.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&Lessons.create_lesson!(&1))
  end

  defp seed_channels(data_folder_path) do
    "#{data_folder_path}/channels.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&Channels.create_channel!(&1))
  end

  defp seed_courses(data_folder_path) do
    "#{data_folder_path}/courses.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_course/1)
  end

  defp insert_course(course) do
    Courses.create_course!(
      course[:youtube_channel_id],
      course,
      language_names: course[:language_names],
      framework_names: course[:framework_names],
      tool_names: course[:tool_names],
      fundamentals_names: course[:fundamentals_names]
    )
  end

  defp seed_platforms(data_folder_path) do
    "#{data_folder_path}/platforms.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_platform/1)
  end

  defp insert_platform(platform) do
    Platforms.create_platform!(
      platform,
      language_names: platform[:language_names],
      framework_names: platform[:framework_names],
      tool_names: platform[:tool_names],
      fundamentals_names: platform[:fundamentals_names]
    )
  end
end
