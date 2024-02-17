defmodule TechschoolWeb.BootcampLiveTest do
  use TechschoolWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "GET /:locale/bootcamps" do
    test "Returns 200 status code", %{conn: conn} do
      assert {:ok, _bootcamp_live, _html} = live(conn, ~p"/en/bootcamps")
    end
  end
end
