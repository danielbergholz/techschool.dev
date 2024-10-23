defmodule Techschool.BootcampsJSONTest do
  use ExUnit.Case

  use Techschool.JSONValidator,
    path: "priv/repo/data/bootcamps.json",
    types: %{
      name: :string,
      icon_name: :string,
      description_en: :string,
      description_pt: :string,
      lesson_names: {:array, :string}
    },
    required: [:name, :icon_name, :description_en, :description_pt]

  setup_all do
    {:ok, bootcamps: get_json()}
  end

  describe "bootcamps JSON validation" do
    test "validates priv/repo/data/bootcamps.json file", %{bootcamps: bootcamps} do
      assert Enum.all?(bootcamps, &validate/1)
    end
  end
end
