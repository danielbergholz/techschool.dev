defmodule Techschool.YouTube do
  @moduledoc """
  Youtube API client
  """

  @base_url "https://www.googleapis.com/youtube/v3"
  @api_key System.get_env("YOUTUBE_API_KEY")

  def fetch_course(%{youtube_course_id: id, type: type}) do
    video_url = "#{@base_url}/#{type}s?part=snippet&key=#{@api_key}&id=#{id}"

    case Req.get(video_url) do
      {:ok, %{body: body}} -> hd(body["items"])["snippet"]
      _ -> nil
    end
  end

  def fetch_channel(id) do
    channel_url = "#{@base_url}/channels?part=snippet&key=#{@api_key}&id=#{id}"

    case Req.get(channel_url) do
      {:ok, %{body: body}} ->
        hd(body["items"])["snippet"]

      _ ->
        nil
    end
  end
end
