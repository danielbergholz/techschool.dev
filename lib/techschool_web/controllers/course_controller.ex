defmodule TechschoolWeb.CourseController do
  use TechschoolWeb, :controller

  alias Techschool.Courses

  def index(conn, _params) do
    courses = Courses.list_courses()

    conn
    |> assign(:page_title, gettext("Courses") <> " | TechSchool")
    |> assign(:courses, courses)
    |> render(:index)
  end
end
