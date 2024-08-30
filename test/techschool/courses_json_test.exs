defmodule Techschool.CoursesJSONTest do
  use ExUnit.Case

  use Techschool.JSONValidator,
    path: "priv/repo/data/courses.json",
    types: %{
      name: :string,
      youtube_course_id: :string,
      type: :string,
      locale: :string,
      image_url: :string,
      published_at: :string,
      language_names: {:array, :string},
      framework_names: {:array, :string},
      tool_names: {:array, :string},
      fundamentals_names: {:array, :string}
    },
    required: [
      :name,
      :image_url,
      :locale,
      :type,
      :published_at,
      :youtube_course_id
    ]

  setup_all do
    {:ok, courses: get_json()}
  end

  describe "courses JSON validation" do
    test "validates priv/repo/data/courses.json file", %{courses: courses} do
      assert Enum.all?(courses, &validate/1)
    end
  end
end
