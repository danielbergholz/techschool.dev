defmodule TechschoolWeb.PageController do
  use TechschoolWeb, :controller

  @two_hours 2 * 60 * 60

  def home(conn, _params) do
    conn
    |> put_resp_header("cache-control", "public, max-age=#{@two_hours}")
    |> render(:home)
  end
end
