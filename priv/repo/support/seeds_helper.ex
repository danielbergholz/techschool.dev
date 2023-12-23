defmodule Techschool.SeedsHelper do
  alias Techschool.Languages
  alias Techschool.Frameworks

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
end
