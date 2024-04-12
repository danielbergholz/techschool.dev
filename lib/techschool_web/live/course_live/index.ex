defmodule TechschoolWeb.CourseLive.Index do
  use TechschoolWeb, :live_view

  alias Techschool.{Languages, Frameworks, Courses, Tools}
  alias Techschool.Courses.Course

  @default_locale Application.compile_env(:gettext, :default_locale)

  embed_templates "components/*"

  attr :course, Course, required: true
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the container"
  def course_card(assigns)

  attr :language_names, :list, required: true
  attr :framework_names, :list, required: true
  attr :tool_names, :list, required: true
  attr :search, :string, required: true
  attr :selected_language, :string, required: true
  attr :selected_framework, :string, required: true
  attr :selected_tool, :string, required: true
  def search(assigns)

  @impl true
  def mount(_params, _session, socket) do
    language_names = Languages.list_language_names()
    framework_names = Frameworks.list_framework_names()
    tool_names = Tools.list_tool_names()

    socket
    |> assign(:page_title, gettext("Courses") <> " | TechSchool")
    |> assign(
      :page_description,
      gettext(
        "Find the best courses to learn programming! Search by name or filter by language and framework."
      )
    )
    |> assign(:language_names, language_names)
    |> assign(:framework_names, framework_names)
    |> assign(:tool_names, tool_names)
    |> ok()
  end

  @impl true
  def handle_params(params, _url, socket) do
    courses = Courses.search_courses(params, search_locale(socket))

    has_more_courses_to_load = length(courses) == 20

    socket
    |> assign(:selected_language, get_param(params, "language"))
    |> assign(:selected_framework, get_param(params, "framework"))
    |> assign(:selected_tool, get_param(params, "tool"))
    |> assign(:search, get_param(params, "search"))
    |> assign(:offset, 0)
    |> assign(:has_more_courses_to_load, has_more_courses_to_load)
    |> assign(:has_courses, !Enum.empty?(courses))
    |> stream(:courses, courses, reset: true)
    |> noreply()
  end

  @impl true
  def handle_event("load_more", params, socket) do
    offset = socket.assigns.offset + 20

    courses = Courses.search_courses(params, search_locale(socket), offset: offset)

    has_more_courses_to_load = length(courses) == 20

    socket
    |> assign(:offset, offset)
    |> assign(:has_more_courses_to_load, has_more_courses_to_load)
    |> assign(:has_courses, !Enum.empty?(courses))
    |> stream(:courses, courses)
    |> noreply()
  end

  @impl true
  def handle_event("search", params, socket) do
    socket
    |> push_patch(to: build_url(socket, params))
    |> noreply()
  end

  defp build_url(%{assigns: %{locale: locale}}, params) do
    query_params =
      []
      |> add_query_param(params, "framework")
      |> add_query_param(params, "language")
      |> add_query_param(params, "tool")
      |> add_query_param(params, "search")
      |> Enum.join("&")

    case query_params do
      "" -> "/#{locale}/courses"
      _ -> "/#{locale}/courses?#{query_params}"
    end
  end

  defp get_param(params, param_name) do
    Map.get(params, param_name, "")
  end

  defp add_query_param(list, params, key) do
    case get_param(params, key) do
      "" -> list
      value -> ["#{key}=#{String.downcase(value)}" | list]
    end
  end

  defp search_locale(%{assigns: %{locale: locale}}) do
    case locale do
      @default_locale -> [@default_locale]
      _ -> [locale, @default_locale]
    end
  end

  defp search_locale(_), do: [@default_locale]
end
