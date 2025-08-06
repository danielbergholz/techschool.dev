defmodule TechschoolWeb.CourseLive.Index do
  use TechschoolWeb, :live_view

  alias Techschool.Courses.Course
  alias Techschool.{Courses, Frameworks, Fundamentals, Languages, Locale, Platforms, Tools}
  alias Techschool.Platforms.Platform

  @default_locale Locale.get_default_locale()

  embed_templates "components/*"

  attr :course, Course, required: true
  attr :new, :boolean, default: false
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the container"
  def course_card(assigns)

  attr :platform, Platform, required: true
  attr :locale, :string, required: true
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the container"
  def platform_card(assigns)

  attr :language_names, :list, required: true
  attr :framework_names, :list, required: true
  attr :tool_names, :list, required: true
  attr :fundamentals_names, :list, required: true
  attr :search, :string, required: true
  attr :selected_language, :string, required: true
  attr :selected_framework, :string, required: true
  attr :selected_tool, :string, required: true
  attr :selected_fundamentals, :string, required: true
  def search(assigns)

  @impl true
  def mount(_params, _session, socket) do
    # filters
    language_names = Languages.list_language_names()
    framework_names = Frameworks.list_framework_names()
    tool_names = Tools.list_tool_names()
    fundamentals_names = Fundamentals.list_fundamentals_names()

    last_courses_ids = Courses.last_courses_ids()

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
    |> assign(:fundamentals_names, fundamentals_names)
    |> assign(:last_courses_ids, last_courses_ids)
    |> assign(:online_users_count, 0)
    |> ok()
  end

  @impl true
  def handle_params(params, _url, socket) do
    course_count = Courses.count_courses(params, search_locale(socket))
    courses = Courses.search_courses(params, search_locale(socket))
    platforms = Platforms.search_platforms(params)

    has_courses = !Enum.empty?(courses)
    has_platforms = !Enum.empty?(platforms)
    no_results = !has_courses && !has_platforms
    has_more_courses_to_load = more_courses_to_load?(courses, course_count, 0)

    socket
    |> assign(:selected_language, get_param(params, "language"))
    |> assign(:selected_framework, get_param(params, "framework"))
    |> assign(:selected_tool, get_param(params, "tool"))
    |> assign(:selected_fundamentals, get_param(params, "fundamentals"))
    |> assign(:search, get_param(params, "search"))
    |> assign(:filter_params, params)
    |> assign(:offset, 0)
    |> assign(:has_more_courses_to_load, has_more_courses_to_load)
    |> assign(:has_courses, has_courses)
    |> assign(:has_platforms, has_platforms)
    |> assign(:no_results, no_results)
    |> assign(:platforms, platforms)
    |> stream(:courses, courses, reset: true)
    |> assign(:course_count, course_count)
    |> noreply()
  end

  @impl true
  def handle_event("load_more", _params, socket) do
    load_more_courses(socket)
  end

  @impl true
  def handle_event("infinite_scroll", _params, socket) do
    load_more_courses(socket)
  end

  @impl true
  def handle_event("search", params, socket) do
    socket
    |> push_patch(to: build_url(socket, params))
    |> noreply()
  end

  @impl true
  def handle_event("course_clicked", %{"course_id" => course_id}, socket) do
    {:ok, updated_course} = Courses.increment_view_count(course_id)

    socket
    |> stream_insert(:courses, updated_course)
    |> noreply()
  end

  defp build_url(%{assigns: %{locale: locale}}, params) do
    query_params =
      []
      |> add_query_param(params, "framework")
      |> add_query_param(params, "language")
      |> add_query_param(params, "tool")
      |> add_query_param(params, "fundamentals")
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

  defp more_courses_to_load?(courses, course_count, offset) do
    length(courses) + offset < course_count
  end

  defp load_more_courses(socket) do
    offset = socket.assigns.offset + 20
    filter_params = socket.assigns.filter_params

    course_count = Courses.count_courses(filter_params, search_locale(socket))
    courses = Courses.search_courses(filter_params, search_locale(socket), offset: offset)

    has_more_courses_to_load = more_courses_to_load?(courses, course_count, offset)

    socket
    |> assign(:offset, offset)
    |> assign(:has_more_courses_to_load, has_more_courses_to_load)
    |> assign(:has_courses, !Enum.empty?(courses))
    |> stream(:courses, courses)
    |> noreply()
  end
end
