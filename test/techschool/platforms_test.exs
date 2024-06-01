defmodule Techschool.PlatformsTest do
  use Techschool.DataCase

  alias Techschool.Platforms

  describe "platforms" do
    alias Techschool.Platforms.Platform

    import Techschool.PlatformsFixtures

    @invalid_attrs %{
      name: nil,
      url: nil,
      description_en: nil,
      description_pt: nil,
      image_url: nil
    }

    test "list_platforms/0 returns all platforms" do
      platform = platform_fixture()
      assert Platforms.list_platforms() == [platform]
    end

    test "get_platform!/1 returns the platform with given id" do
      platform = platform_fixture()
      assert Platforms.get_platform!(platform.id) == platform
    end

    test "create_platform/1 with valid data creates a platform" do
      valid_attrs = %{
        name: "some name",
        url: "some url",
        description_en: "some description_en",
        description_pt: "some description_pt",
        image_url: "some image_url"
      }

      assert {:ok, %Platform{} = platform} = Platforms.create_platform(valid_attrs)
      assert platform.name == "some name"
      assert platform.url == "some url"
      assert platform.description_en == "some description_en"
      assert platform.description_pt == "some description_pt"
      assert platform.image_url == "some image_url"
    end

    test "create_platform/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Platforms.create_platform(@invalid_attrs)
    end

    test "delete_platform/1 deletes the platform" do
      platform = platform_fixture()
      assert {:ok, %Platform{}} = Platforms.delete_platform(platform)
      assert_raise Ecto.NoResultsError, fn -> Platforms.get_platform!(platform.id) end
    end
  end
end
