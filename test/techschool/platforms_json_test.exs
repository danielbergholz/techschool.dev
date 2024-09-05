defmodule Techschool.PlatformsJSONTest do
  use ExUnit.Case

  use Techschool.JSONValidator,
    path: "priv/repo/data/platforms.json",
    types: %{
      name: :string,
      description_en: :string,
      description_pt: :string,
      url: :string,
      image_url: :string,
      language_names: {:array, :string},
      framework_names: {:array, :string},
      tool_names: {:array, :string},
      fundamentals_names: {:array, :string}
    },
    required: [:name, :description_en, :description_pt, :image_url, :url]

  setup_all do
    {:ok, platforms: get_json()}
  end

  describe "platforms JSON validation" do
    test "validates priv/repo/data/platforms.json file", %{platforms: platforms} do
      assert Enum.all?(platforms, &validate/1)
    end
  end
end
