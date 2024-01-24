defmodule TechschoolWeb.PageControllerTest do
  use TechschoolWeb.ConnCase

  describe "GET /" do
    test "Redirects to /:locale", %{conn: conn} do
      conn = get(conn, ~p"/")
      assert conn.status == 302
    end
  end
end
