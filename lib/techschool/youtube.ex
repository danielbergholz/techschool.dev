defmodule Techschool.YouTube do
  @moduledoc """
  Youtube API client
  """

  alias Techschool.Courses

  @base_url "https://www.googleapis.com/youtube/v3"

  def fetch_course(%{youtube_course_id: id}) do
    api_key = System.get_env("YOUTUBE_API_KEY")
    type = Courses.course_type(id)
    video_url = "#{@base_url}/#{type}s?part=snippet&key=#{api_key}&id=#{id}"

    case Req.get(video_url) do
      {:ok, %{body: body}} -> hd(body["items"])["snippet"]
      _ -> nil
    end
  end

  def fetch_channel(id) do
    api_key = System.get_env("YOUTUBE_API_KEY")
    channel_url = "#{@base_url}/channels?part=snippet&key=#{api_key}&id=#{id}"

    case Req.get(channel_url) do
      {:ok, %{body: body}} ->
        hd(body["items"])["snippet"]

      _ ->
        nil
    end
  end
end
