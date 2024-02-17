defmodule Techschool.ToolsTest do
  use Techschool.DataCase

  alias Techschool.Tools

  describe "tools" do
    alias Techschool.Tools.Tool

    import Techschool.ToolsFixtures

    @invalid_attrs %{name: nil}

    test "list_tools/0 returns all tools" do
      tool = tool_fixture()
      assert Tools.list_tools() == [tool]
    end

    test "get_tool!/1 returns the tool with given id" do
      tool = tool_fixture()
      assert Tools.get_tool!(tool.id) == tool
    end

    test "create_tool/1 with valid data creates a tool" do
      valid_attrs = %{name: "some name", image_url: "some image_url"}

      assert {:ok, %Tool{} = tool} = Tools.create_tool(valid_attrs)
      assert tool.name == "some name"
    end

    test "create_tool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tools.create_tool(@invalid_attrs)
    end

    test "delete_tool/1 deletes the tool" do
      tool = tool_fixture()
      assert {:ok, %Tool{}} = Tools.delete_tool(tool)
      assert_raise Ecto.NoResultsError, fn -> Tools.get_tool!(tool.id) end
    end
  end
end
