defmodule Techschool.SeedsHelper do
  alias Techschool.{Languages, Frameworks, Channels}

  def seed_languages() do
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

  def seed_frameworks() do
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

  def seed_channels() do
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
end
