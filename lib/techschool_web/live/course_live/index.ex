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
    |> stream(:courses, [])
    |> ok()
  end

  @impl true
  def handle_params(params, _url, socket) do
    socket
    |> stream(:courses, Courses.list_courses(params), reset: true)
    |> noreply()
  end

  @impl true
  def handle_event("search", params, socket) do
    socket
    |> push_patch(to: build_url(socket, params))
    |> noreply()
  end

  defp build_url(%{assigns: %{locale: locale}}, %{"search" => search}) do
    "/#{locale}/courses?search=#{search}"
  end

  defp build_url(%{assigns: %{locale: locale}}, _params) do
    "/#{locale}/courses"
  end
end
