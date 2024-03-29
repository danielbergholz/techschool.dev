defmodule Techschool.ChannelsTest do
  use Techschool.DataCase

  alias Techschool.Channels

  describe "channels" do
    alias Techschool.Channels.Channel

    import Techschool.ChannelsFixtures

    @invalid_attrs %{name: nil, image_url: nil, youtube_channel_id: nil}

    test "list_channels/0 returns all channels with URLs generated" do
      channel = channel_fixture()
      assert Channels.list_channels() == [channel]
    end

    test "get_channel!/1 returns the channel by id with URL generated" do
      channel = channel_fixture()
      assert Channels.get_channel!(channel.id) == channel
    end

    test "create_channel/1 with valid data creates a channel" do
      valid_attrs = %{
        name: "some name",
        image_url: "some image_url",
        youtube_channel_id: "some youtube_channel_id"
      }

      assert {:ok, %Channel{} = channel} = Channels.create_channel(valid_attrs)
      assert channel.name == "some name"
      assert channel.image_url == "some image_url"
      assert channel.youtube_channel_id == "some youtube_channel_id"
    end

    test "create_channel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Channels.create_channel(@invalid_attrs)
    end

    test "delete_channel/1 deletes the channel" do
      channel = channel_fixture()
      assert {:ok, %Channel{}} = Channels.delete_channel(channel)
      assert_raise Ecto.NoResultsError, fn -> Channels.get_channel!(channel.id) end
    end
  end
end
