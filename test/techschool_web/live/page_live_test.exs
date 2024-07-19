defmodule TechschoolWeb.PageLiveTest do
  use TechschoolWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "GET /:locale" do
    test "Returns 200 status code", %{conn: conn} do
      assert {:ok, view, html} = live(conn, ~p"/en")
      assert html =~ "TechSchool"

      assert has_element?(view, "#online_users_count", "1")
    end
  end
end
