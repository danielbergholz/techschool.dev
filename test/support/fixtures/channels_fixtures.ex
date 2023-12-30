defmodule Techschool.ChannelsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Techschool.Channels` context.
  """

  @doc """
  Generate a unique channel channel_id.
  """
  def unique_channel_channel_id, do: "some channel_id#{System.unique_integer([:positive])}"

  @doc """
  Generate a channel.
  """
  def channel_fixture(attrs \\ %{}) do
    {:ok, channel} =
      attrs
      |> Enum.into(%{
        channel_id: unique_channel_channel_id(),
        image_url: "some image_url",
        name: "some name"
      })
      |> Techschool.Channels.create_channel()

    channel
  end
end
