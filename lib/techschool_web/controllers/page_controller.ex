defmodule TechschoolWeb.PageController do
  use TechschoolWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
