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

  defp build_url(%{assigns: %{locale: locale}}, %{
         "search" => search,
         "language" => language,
         "framework" => framework
       }) do
    case {search, language, framework} do
      {"", "", ""} ->
        "/#{locale}/courses"

      {_, _, _} ->
        "/#{locale}/courses?search=#{String.downcase(search)}&language=#{String.downcase(language)}&framework=#{String.downcase(framework)}"
    end
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
