defmodule TechschoolWeb.BootcampLiveTest do
  use TechschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Techschool.BootcampsFixtures
  import Techschool.LessonsFixtures

  alias TechschoolWeb.Plugs.SetLocale

  describe "GET /:locale/bootcamps" do
    test "lists all bootcamps", %{conn: conn} do
      bootcamp = bootcamp_fixture()

      assert {:ok, _bootcamp_live, html} = live(conn, ~p"/en/bootcamps")
      assert html =~ bootcamp.name
    end
  end

  describe "GET /:locale/bootcamps/:slug" do
    for locale <- SetLocale.get_available_locales() do
      @tag locale: locale
      test "lists all lessons from a bootcamp for #{locale} locale", %{conn: conn, locale: locale} do
        lesson = lesson_fixture()
        bootcamp = bootcamp_fixture(lesson_names: [lesson.name])
        description_variant = "description_#{locale}" |> String.to_atom()
        {:ok, _bootcamp_live, html} = live(conn, ~p"/#{locale}/bootcamps/#{bootcamp.slug}")
        bootcamp_description = Map.get(bootcamp, description_variant)
        assert html =~ bootcamp.name
        assert html =~ bootcamp_description
      end
    end
  end
end
