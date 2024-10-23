defmodule Techschool.ToolsJSONTest do
  use ExUnit.Case

  use Techschool.JSONValidator,
    path: "priv/repo/data/tools.json",
    types: %{
      name: :string,
      icon_name: :string
    },
    required: [:name, :icon_name]

  setup_all do
    {:ok, tools: get_json()}
  end

  describe "tools JSON validation" do
    test "validates priv/repo/data/tools.json file", %{tools: tools} do
      assert Enum.all?(tools, &validate/1)
    end
  end
end
