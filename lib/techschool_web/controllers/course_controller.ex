defmodule TechschoolWeb.CourseController do
  use TechschoolWeb, :controller

  alias Techschool.Courses

  @one_day 60 * 60 * 24

  def index(conn, _params) do
    courses = Courses.list_courses()

    conn
    |> put_resp_header("cache-control", "public, max-age=#{@one_day}")
    |> assign(:page_title, gettext("Courses") <> " | TechSchool")
    |> assign(:courses, courses)
    |> render(:index)
  end
end
