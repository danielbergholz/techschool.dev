defmodule TechschoolWeb.CourseLive.Index do
  use TechschoolWeb, :live_view

  alias Techschool.Languages
  alias Techschool.Frameworks
  alias Techschool.Courses
  alias Techschool.Courses.Course

  @default_locale Application.compile_env(:gettext, :default_locale)

  embed_templates "components/*"

  attr :course, Course, required: true
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the container"
  def course_card(assigns)

  attr :language_names, :list, required: true
  attr :framework_names, :list, required: true
  def search(assigns)

  @impl true
  def mount(_params, _session, socket) do
    language_names = Languages.list_language_names()
    framework_names = Frameworks.list_framework_names()

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

  defp build_url(%{assigns: %{locale: locale}}, params) do
    search = Map.get(params, "search", "")
    language_name = Map.get(params, "language", "")
    framework_name = Map.get(params, "framework", "")

    query_params =
      []
      |> add_query_param("framework", String.downcase(framework_name))
      |> add_query_param("language", String.downcase(language_name))
      |> add_query_param("search", String.downcase(search))
      |> Enum.join("&")

    case query_params do
      "" -> "/#{locale}/courses"
      _ -> "/#{locale}/courses?#{query_params}"
    end
  end

  defp add_query_param(list, key, value) when value != "" do
    ["#{key}=#{value}" | list]
  end

  defp add_query_param(list, _key, _value) do
    list
  end

  defp search_locale(%{assigns: %{locale: locale}}) do
    case locale do
      @default_locale -> [@default_locale]
      _ -> [locale, @default_locale]
    end
  end

  defp search_locale(_), do: [@default_locale]
end
