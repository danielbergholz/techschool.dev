defmodule TechschoolWeb.PageController do
  use TechschoolWeb, :controller

  @one_day 60 * 60 * 24

  def home(conn, _params) do
    conn
    |> put_resp_header("cache-control", "public, max-age=#{@one_day}")
    |> render(:home)
  end
end
