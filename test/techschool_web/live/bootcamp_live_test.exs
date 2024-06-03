defmodule TechschoolWeb.BootcampLiveTest do
  use TechschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Techschool.BootcampsFixtures
  import Techschool.LessonsFixtures

  describe "GET /:locale/bootcamps" do
    test "lists all bootcamps", %{conn: conn} do
      bootcamp = bootcamp_fixture()

      assert {:ok, _bootcamp_live, html} = live(conn, ~p"/en/bootcamps")
      assert html =~ bootcamp.name
    end
  end

  describe "GET /:locale/bootcamps/:slug" do
    test "lists all lessons from a bootcamp", %{conn: conn} do
      lesson = lesson_fixture()
      bootcamp = bootcamp_fixture(lesson_names: [lesson.name])

      assert {:ok, _bootcamp_live, html} = live(conn, ~p"/en/bootcamps/#{bootcamp.slug}")
      assert html =~ bootcamp.name
      assert html =~ lesson.description_en
    end
  end
end
