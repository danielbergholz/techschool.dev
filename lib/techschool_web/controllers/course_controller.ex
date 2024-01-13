defmodule TechschoolWeb.CourseController do
  use TechschoolWeb, :controller

  alias Techschool.Courses

  @one_hour 1 * 60 * 60

  def index(conn, _params) do
    courses = Courses.list_courses()

    conn
    |> put_resp_header("cache-control", "public, max-age=#{@one_hour}")
    |> assign(:page_title, gettext("Courses") <> " | TechSchool")
    |> assign(:courses, courses)
    |> render(:index)
  end
end
