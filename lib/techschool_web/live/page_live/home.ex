defmodule TechschoolWeb.PageLive.Home do
  use TechschoolWeb, :live_view

  alias Techschool.{GitHub, Courses}

  embed_templates "components/*"

  attr :inverse_locale, :string, required: true
  def translate_button(assigns)

  defp inverse_locale(locale) do
    case locale do
      "pt" -> "en"
      "en" -> "pt"
    end
  end

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> assign(:page_title, "TechSchool")
    |> assign(:last_updated, Courses.last_updated())
    |> assign(:platform_stats, Courses.get_platform_stats())
    |> assign_async(:github_contributors, fn ->
      {:ok, %{github_contributors: GitHub.get_contributors()}}
    end)
    |> ok()
  end
end
