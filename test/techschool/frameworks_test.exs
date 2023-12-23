defmodule Techschool.FrameworksTest do
  use Techschool.DataCase

  alias Techschool.Frameworks

  describe "frameworks" do
    alias Techschool.Frameworks.Framework

    import Techschool.FrameworksFixtures

    @invalid_attrs %{name: nil, image_url: nil}

    test "list_frameworks/0 returns all frameworks" do
      framework = framework_fixture()
      assert Frameworks.list_frameworks() == [framework]
    end

    test "get_framework!/1 returns the framework with given id" do
      framework = framework_fixture()
      assert Frameworks.get_framework!(framework.id) == framework
    end

    test "create_framework/1 with valid data creates a framework" do
      valid_attrs = %{name: "some name", image_url: "some image_url"}

      assert {:ok, %Framework{} = framework} = Frameworks.create_framework(valid_attrs)
      assert framework.name == "some name"
      assert framework.image_url == "some image_url"
    end

    test "create_framework/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Frameworks.create_framework(@invalid_attrs)
    end

    test "update_framework/2 with valid data updates the framework" do
      framework = framework_fixture()
      update_attrs = %{name: "some updated name", image_url: "some updated image_url"}

      assert {:ok, %Framework{} = framework} = Frameworks.update_framework(framework, update_attrs)
      assert framework.name == "some updated name"
      assert framework.image_url == "some updated image_url"
    end

    test "update_framework/2 with invalid data returns error changeset" do
      framework = framework_fixture()
      assert {:error, %Ecto.Changeset{}} = Frameworks.update_framework(framework, @invalid_attrs)
      assert framework == Frameworks.get_framework!(framework.id)
    end

    test "delete_framework/1 deletes the framework" do
      framework = framework_fixture()
      assert {:ok, %Framework{}} = Frameworks.delete_framework(framework)
      assert_raise Ecto.NoResultsError, fn -> Frameworks.get_framework!(framework.id) end
    end

    test "change_framework/1 returns a framework changeset" do
      framework = framework_fixture()
      assert %Ecto.Changeset{} = Frameworks.change_framework(framework)
    end
  end
end
