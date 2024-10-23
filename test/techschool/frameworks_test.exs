defmodule Techschool.FrameworksTest do
  use Techschool.DataCase

  alias Techschool.Frameworks

  describe "frameworks" do
    alias Techschool.Frameworks.Framework

    import Techschool.FrameworksFixtures

    @invalid_attrs %{name: nil, icon_name: nil}

    test "list_frameworks/0 returns all frameworks" do
      framework = framework_fixture()
      assert Frameworks.list_frameworks() == [framework]
    end

    test "get_framework!/1 returns the framework with given id" do
      framework = framework_fixture()
      assert Frameworks.get_framework!(framework.id) == framework
    end

    test "create_framework/1 with valid data creates a framework" do
      valid_attrs = %{name: "some name", icon_name: "some icon_name"}

      assert {:ok, %Framework{} = framework} = Frameworks.create_framework(valid_attrs)
      assert framework.name == "some name"
      assert framework.icon_name == "some icon_name"
    end

    test "create_framework/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Frameworks.create_framework(@invalid_attrs)
    end

    test "delete_framework/1 deletes the framework" do
      framework = framework_fixture()
      assert {:ok, %Framework{}} = Frameworks.delete_framework(framework)
      assert_raise Ecto.NoResultsError, fn -> Frameworks.get_framework!(framework.id) end
    end
  end
end
