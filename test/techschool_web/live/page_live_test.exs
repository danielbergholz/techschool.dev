defmodule TechschoolWeb.PageLiveTest do
  use TechschoolWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "GET /:locale" do
    test "Returns 200 status code", %{conn: conn} do
      assert {:ok, _view, html} = live(conn, ~p"/en")
      assert html =~ "TechSchool"
    end
  end
end
