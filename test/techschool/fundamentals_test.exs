defmodule Techschool.FundamentalsTest do
  use Techschool.DataCase

  alias Techschool.Fundamentals

  describe "fundamentals" do
    alias Techschool.Fundamentals.Fundamental

    import Techschool.FundamentalsFixtures

    @invalid_attrs %{name: nil, image_url: nil}

    test "list_fundamentals/0 returns all fundamentals" do
      fundamental = fundamental_fixture()
      assert Fundamentals.list_fundamentals() == [fundamental]
    end

    test "get_fundamental!/1 returns the fundamental with given id" do
      fundamental = fundamental_fixture()
      assert Fundamentals.get_fundamental!(fundamental.id) == fundamental
    end

    test "create_fundamental/1 with valid data creates a fundamental" do
      valid_attrs = %{
        name: "some name",
        image_url: "some image_url"
      }

      assert {:ok, %Fundamental{} = fundamental} = Fundamentals.create_fundamental(valid_attrs)
      assert fundamental.name == "some name"
      assert fundamental.image_url == "some image_url"
    end

    test "create_fundamental/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fundamentals.create_fundamental(@invalid_attrs)
    end

    test "delete_fundamental/1 deletes the fundamental" do
      fundamental = fundamental_fixture()
      assert {:ok, %Fundamental{}} = Fundamentals.delete_fundamental(fundamental)
      assert_raise Ecto.NoResultsError, fn -> Fundamentals.get_fundamental!(fundamental.id) end
    end
  end
end
