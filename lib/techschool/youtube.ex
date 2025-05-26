defmodule Techschool.YouTube do
  @moduledoc """
  Youtube API client
  """

  alias Techschool.Courses
  require Logger

  @base_url "https://www.googleapis.com/youtube/v3"

  def fetch_course(%{youtube_course_id: id}) do
    with api_key when not is_nil(api_key) <- System.get_env("YOUTUBE_API_KEY") do
      type = Courses.course_type(id)
      video_url = "#{@base_url}/#{type}s?part=snippet&key=#{api_key}&id=#{id}"

      case Req.get(video_url) do
        {:ok, %{status: status, body: body_content}} when status >= 200 and status < 300 ->
          cond do
            is_map(body_content) and is_list(body_content["items"]) and
                body_content["items"] != [] ->
              item = hd(body_content["items"])

              if is_map(item) and Map.has_key?(item, "snippet") do
                item["snippet"]
              else
                Logger.warning("""
                [YouTube API] Course ID '#{id}': First item in 'items' list is missing 'snippet' or is not a map.
                Item: #{inspect(item)}
                Full response body: #{inspect(body_content)}
                """)

                nil
              end

            is_map(body_content) and is_list(body_content["items"]) and
                body_content["items"] == [] ->
              Logger.warning("""
              [YouTube API] Course ID '#{id}': Received empty 'items' list.
              URL: #{video_url}
              Full response body: #{inspect(body_content)}
              """)

              nil

            true ->
              Logger.warning("""
              [YouTube API] Course ID '#{id}': Unexpected response body structure.
              URL: #{video_url}
              Expected map with 'items' list. Got: #{inspect(body_content)}
              """)

              nil
          end

        {:ok, %{status: status, body: body_content}} ->
          Logger.error("""
          [YouTube API] Course ID '#{id}': Request failed with HTTP status #{status}.
          URL: #{video_url}
          Response body: #{inspect(body_content)}
          """)

          nil

        {:error, reason} ->
          Logger.error("""
          [YouTube API] Course ID '#{id}': Req.get request failed.
          URL: #{video_url}
          Reason: #{inspect(reason)}
          """)

          nil

        other ->
          Logger.error("""
          [YouTube API] Course ID '#{id}': Unexpected result from Req.get.
          URL: #{video_url}
          Result: #{inspect(other)}
          """)

          nil
      end
    else
      _ ->
        Logger.error(
          "[YouTube API] YOUTUBE_API_KEY environment variable is not set. Cannot fetch course ID: #{id}."
        )

        nil
    end
  end

  def fetch_channel(id) do
    with api_key when not is_nil(api_key) <- System.get_env("YOUTUBE_API_KEY") do
      channel_url = "#{@base_url}/channels?part=snippet&key=#{api_key}&id=#{id}"

      case Req.get(channel_url) do
        {:ok, %{status: status, body: body_content}} when status >= 200 and status < 300 ->
          cond do
            is_map(body_content) and is_list(body_content["items"]) and
                body_content["items"] != [] ->
              item = hd(body_content["items"])

              if is_map(item) and Map.has_key?(item, "snippet") do
                item["snippet"]
              else
                Logger.warning("""
                [YouTube API] Channel ID '#{id}': First item in 'items' list is missing 'snippet' or is not a map.
                Item: #{inspect(item)}
                Full response body: #{inspect(body_content)}
                """)

                nil
              end

            is_map(body_content) and is_list(body_content["items"]) and
                body_content["items"] == [] ->
              Logger.warning("""
              [YouTube API] Channel ID '#{id}': Received empty 'items' list.
              URL: #{channel_url}
              Full response body: #{inspect(body_content)}
              """)

              nil

            true ->
              Logger.warning("""
              [YouTube API] Channel ID '#{id}': Unexpected response body structure.
              URL: #{channel_url}
              Expected map with 'items' list. Got: #{inspect(body_content)}
              """)

              nil
          end

        {:ok, %{status: status, body: body_content}} ->
          Logger.error("""
          [YouTube API] Channel ID '#{id}': Request failed with HTTP status #{status}.
          URL: #{channel_url}
          Response body: #{inspect(body_content)}
          """)

          nil

        {:error, reason} ->
          Logger.error("""
          [YouTube API] Channel ID '#{id}': Req.get request failed.
          URL: #{channel_url}
          Reason: #{inspect(reason)}
          """)

          nil

        other ->
          Logger.error("""
          [YouTube API] Channel ID '#{id}': Unexpected result from Req.get.
          URL: #{channel_url}
          Result: #{inspect(other)}
          """)

          nil
      end
    else
      _ ->
        Logger.error(
          "[YouTube API] YOUTUBE_API_KEY environment variable is not set. Cannot fetch channel ID: #{id}."
        )

        nil
    end
  end
end
