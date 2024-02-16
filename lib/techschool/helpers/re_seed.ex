defmodule Techschool.Helpers.ReSeed do
  alias Techschool.{Languages, Frameworks, Channels, Courses, Tools, Bootcamps, Lessons}

  def call(data_folder_path \\ "priv/repo/data") do
    seed_languages(data_folder_path)
    seed_frameworks(data_folder_path)
    seed_tools(data_folder_path)
    seed_bootcamps(data_folder_path)
    seed_lessons(data_folder_path)
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

  defp seed_tools(data_folder_path) do
    "#{data_folder_path}/tools.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_tool/1)
  end

  defp insert_tool(tool) do
    Tools.create_tool(%{
      name: tool[:name]
    })
  end

  defp seed_bootcamps(data_folder_path) do
    "#{data_folder_path}/bootcamps.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_bootcamp/1)
  end

  defp insert_bootcamp(bootcamp) do
    Bootcamps.create_bootcamp(%{
      name: bootcamp[:name],
      image_url: bootcamp[:image_url],
      description_en: bootcamp[:description_en],
      description_pt: bootcamp[:description_pt]
    })
  end

  defp seed_lessons(data_folder_path) do
    "#{data_folder_path}/lessons.json"
    |> File.read!()
    |> Jason.decode!(keys: :atoms)
    |> Enum.each(&insert_lesson/1)
  end

  defp insert_lesson(lesson) do
    Lessons.create_lesson(%{
      name: lesson[:name],
      optional: lesson[:optional],
      image_url: lesson[:image_url],
      description_en: lesson[:description_en],
      description_pt: lesson[:description_pt],
      language_names: lesson[:language_names],
      framework_names: lesson[:framework_names],
      tool_names: lesson[:tool_names]
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
      course[:youtube_channel_id],
      %{
        name: course[:name],
        type: course[:type],
        locale: course[:locale],
        image_url: course[:image_url],
        published_at: course[:published_at],
        youtube_course_id: course[:youtube_course_id]
      },
      language_names: course[:language_names],
      framework_names: course[:framework_names],
      tool_names: course[:tool_names]
    )
  end
end
