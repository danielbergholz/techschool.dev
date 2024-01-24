defmodule TechschoolWeb.PageController do
  use TechschoolWeb, :controller

  def index(conn, _params) do
    conn
    |> redirect(to: "/#{conn.assigns.locale}")
  end
end
