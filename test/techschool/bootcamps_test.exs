defmodule Techschool.BootcampsTest do
  use Techschool.DataCase

  alias Techschool.Bootcamps

  describe "bootcamps" do
    alias Techschool.Bootcamps.Bootcamp

    import Techschool.BootcampsFixtures

    @invalid_attrs %{name: nil, icon_name: nil, description_en: nil, description_pt: nil}

    test "list_bootcamps/0 returns all bootcamps" do
      bootcamp = bootcamp_fixture()
      assert Bootcamps.list_bootcamps() == [bootcamp]
    end

    test "get_bootcamp!/1 returns the bootcamp with given id" do
      bootcamp = bootcamp_fixture()
      assert Bootcamps.get_bootcamp!(bootcamp.id) == bootcamp
    end

    test "create_bootcamp/1 with valid data creates a bootcamp" do
      valid_attrs = %{
        name: "some name",
        icon_name: "some icon_name",
        description_en: "some description_en",
        description_pt: "some description_pt"
      }

      assert {:ok, %Bootcamp{} = bootcamp} = Bootcamps.create_bootcamp(valid_attrs)
      assert bootcamp.name == "some name"
      assert bootcamp.icon_name == "some icon_name"
      assert bootcamp.description_en == "some description_en"
      assert bootcamp.description_pt == "some description_pt"
    end

    test "create_bootcamp/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bootcamps.create_bootcamp(@invalid_attrs)
    end

    test "delete_bootcamp/1 deletes the bootcamp" do
      bootcamp = bootcamp_fixture()
      assert {:ok, %Bootcamp{}} = Bootcamps.delete_bootcamp(bootcamp)
      assert_raise Ecto.NoResultsError, fn -> Bootcamps.get_bootcamp!(bootcamp.id) end
    end
  end
end
