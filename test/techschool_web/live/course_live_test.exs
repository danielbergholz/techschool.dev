defmodule TechschoolWeb.CourseLiveTest do
  use TechschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Techschool.{CoursesFixtures, ChannelsFixtures}

  describe "GET /:locale/courses" do
    test "lists all courses", %{conn: conn} do
      channel = channel_fixture()
      course = course_fixture(channel.youtube_channel_id)

      assert {:ok, _index_live, html} = live(conn, ~p"/en/courses")
      assert html =~ course.name
    end
  end
end
