defmodule Techschool.LanguagesJSONTest do
  use ExUnit.Case

  use Techschool.JSONValidator,
    path: "priv/repo/data/languages.json",
    types: %{
      name: :string,
      image_url: :string
    },
    required: [:name]

  setup_all do
    {:ok, languages: get_json()}
  end

  describe "languages JSON validation" do
    test "validates priv/repo/data/languages.json file", %{languages: languages} do
      assert Enum.all?(languages, &validate/1)
    end
  end
end
