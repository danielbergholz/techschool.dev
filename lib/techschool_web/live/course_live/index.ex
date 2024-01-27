defmodule TechschoolWeb.CourseLive.Index do
  use TechschoolWeb, :live_view

  alias Techschool.Courses
  alias Techschool.Courses.Course

  @default_locale Application.compile_env(:gettext, :default_locale)

  embed_templates "components/*"

  attr :course, Course, required: true
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the container"
  def course_card(assigns)

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> assign(:page_title, gettext("Courses") <> " | TechSchool")
    |> ok()
  end

  @impl true
  def handle_params(params, _url, socket) do
    socket
    |> stream(:courses, Courses.search_courses(params, search_locale(socket)), reset: true)
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

  defp search_locale(%{assigns: %{locale: locale}}) do
    case locale do
      @default_locale -> [@default_locale]
      _ -> [locale, @default_locale]
    end
  end

  defp search_locale(_), do: [@default_locale]
end
