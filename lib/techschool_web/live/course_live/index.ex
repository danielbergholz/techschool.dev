defmodule TechschoolWeb.CourseLive.Index do
  use TechschoolWeb, :live_view

  alias Techschool.Courses
  alias Techschool.Courses.Course

  embed_templates "components/*"

  attr :course, Course, required: true
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the container"
  def course_card(assigns)

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> assign(:page_title, gettext("Courses") <> " | TechSchool")
    |> stream(:courses, Courses.list_courses())
    |> ok()
  end
end
