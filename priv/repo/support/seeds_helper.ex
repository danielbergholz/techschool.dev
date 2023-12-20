defmodule Techschool.SeedsHelper do
  alias Techschool.Languages

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
end
