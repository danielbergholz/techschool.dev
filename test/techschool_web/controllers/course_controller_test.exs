defmodule TechschoolWeb.CourseControllerTest do
  use TechschoolWeb.ConnCase

  import Techschool.{CoursesFixtures, ChannelsFixtures}

  describe "index" do
    test "lists all courses", %{conn: conn} do
      channel = channel_fixture()
      course = course_fixture(channel.youtube_channel_id)

      conn = get(conn, ~p"/courses")
      assert html_response(conn, 200) =~ course.name
    end
  end
end
