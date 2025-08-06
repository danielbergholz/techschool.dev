defmodule TechschoolWeb.CourseLiveTest do
  use TechschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Techschool.{CoursesFixtures, ChannelsFixtures, PlatformsFixtures, Locale}

  describe "GET /:locale/courses" do
    for locale <- get_available_locales() do
      @tag locale: locale
      test "lists all courses and platforms for #{locale} locale", %{conn: conn, locale: locale} do
        channel = channel_fixture()
        course = course_fixture(channel.youtube_channel_id)
        platform = platform_fixture()
        description_variant = "description_#{locale}" |> String.to_atom()
        {:ok, _index_live, html} = live(conn, ~p"/#{locale}/courses")
        platform_description = Map.get(platform, description_variant)
        assert html =~ platform_description
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
      refute html =~ "Loading more courses..."
    end

    test "must return results when courses are found and show loading indicator when returns more than 20 results",
         %{conn: conn} do
      for _ <- 1..21 do
        course_fixture(channel_fixture().youtube_channel_id)
      end

      assert {:ok, _index_live, html} = live(conn, ~p"/en/courses?search=some name")
      assert html =~ "some name"
      assert html =~ "Loading more courses..."
      assert html =~ "infinite-scroll-trigger"
    end

    test "must return message 'no results' when courses are not found", %{conn: conn} do
      channel = channel_fixture()
      course = course_fixture(channel.youtube_channel_id)

      assert {:ok, _index_live, html} = live(conn, ~p"/en/courses?search=invalid")
      assert html =~ "No results for the given search"
      refute html =~ course.name
      refute html =~ "Loading more courses..."
    end
  end
end
