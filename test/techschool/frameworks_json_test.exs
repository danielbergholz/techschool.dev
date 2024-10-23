defmodule Techschool.FrameworksJSONTest do
  use ExUnit.Case

  use Techschool.JSONValidator,
    path: "priv/repo/data/frameworks.json",
    types: %{name: :string, icon_name: :string},
    required: [:name]

  setup_all do
    {:ok, frameworks: get_json()}
  end

  describe "frameworks JSON validation" do
    test "validates priv/repo/data/frameworks.json file", %{frameworks: frameworks} do
      assert Enum.all?(frameworks, &validate/1)
    end
  end
end
