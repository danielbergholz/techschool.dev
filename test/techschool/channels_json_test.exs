defmodule Techschool.ChannelsJSONTest do
  use ExUnit.Case

  use Techschool.JSONValidator,
    path: "priv/repo/data/channels.json",
    types: %{
      name: :string,
      image_url: :string,
      youtube_channel_id: :string
    },
    required: [:name, :image_url, :youtube_channel_id]

  setup_all do
    {:ok, channels: get_json()}
  end

  describe "channels JSON validation" do
    test "validates priv/repo/data/channels.json file", %{channels: channels} do
      assert Enum.all?(channels, &validate/1)
    end
  end
end
