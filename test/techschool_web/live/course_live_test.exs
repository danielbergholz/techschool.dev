defmodule TechschoolWeb.CourseLiveTest do
  use TechschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Techschool.{CoursesFixtures, ChannelsFixtures, PlatformsFixtures}

  alias TechschoolWeb.Plugs.SetLocale

  describe "GET /:locale/courses" do
    test "lists all courses and platforms", %{conn: conn} do
      channel = channel_fixture()
      course = course_fixture(channel.youtube_channel_id)
      platform = platform_fixture()

      for locale <- SetLocale.get_available_locales() do
        description_variant = "description_#{locale}"
        {:ok, _index_live, html} = live(conn, "/#{locale}/courses")
        description = Map.get(platform, String.to_atom(description_variant))
        assert html =~ description
        assert html =~ course.name
        assert html =~ platform.name
      end
    end
  end

  describe "GET /:locale/courses with search query string" do
    test "must return results when courses are found", %{conn: conn} do
      channel = channel_fixture()
      course = course_fixture(channel.youtube_channel_id)

      assert {:ok, _index_live, html} = live(conn, ~p"/en/courses?search=#{course.name}")
      assert html =~ course.name
      refute html =~ "Load More"
    end

    test "must return results when courses are found and show 'Load more' when returns more than 20 results",
         %{conn: conn} do
      for _ <- 1..21 do
        course_fixture(channel_fixture().youtube_channel_id)
      end

      assert {:ok, _index_live, html} = live(conn, ~p"/en/courses?search=some name")
      assert html =~ "some name"
      assert html =~ "Load More"
    end

    test "must return message 'no results' when courses are not found", %{conn: conn} do
      channel = channel_fixture()
      course = course_fixture(channel.youtube_channel_id)

      assert {:ok, _index_live, html} = live(conn, ~p"/en/courses?search=invalid")
      assert html =~ "No results for the given search"
      refute html =~ course.name
      refute html =~ "Load More"
    end
  end
end
