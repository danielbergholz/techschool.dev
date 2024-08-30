defmodule Techschool.LessonsJSONTest do
  use ExUnit.Case

  use Techschool.JSONValidator,
    path: "priv/repo/data/lessons.json",
    types: %{
      name: :string,
      optional: :boolean,
      image_url: :string,
      description_en: :string,
      description_pt: :string,
      language_names: :string,
      framework_names: :string,
      tool_names: :string,
      fundamentals_names: :string
    },
    required: [:name, :optional, :image_url, :description_en, :description_pt]

  setup_all do
    {:ok, lessons: get_json()}
  end

  describe "lessons JSON validation" do
    test "validates priv/repo/data/lessons.json file", %{lessons: lessons} do
      assert Enum.all?(lessons, &validate/1)
    end
  end
end
