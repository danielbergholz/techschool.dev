defmodule TechschoolWeb.PageControllerTest do
  use TechschoolWeb.ConnCase

  describe "GET /" do
    test "Returns 200 status code", %{conn: conn} do
      conn = get(conn, ~p"/")
      assert html_response(conn, 200) =~ "TechSchool"
    end

    test "Has a non private cache-control header", %{conn: conn} do
      conn = get(conn, ~p"/")
      assert {"cache-control", cache_value} = List.keyfind!(conn.resp_headers, "cache-control", 0)
      refute String.contains?(cache_value, "private")
    end
  end
end
