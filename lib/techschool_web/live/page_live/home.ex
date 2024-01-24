defmodule TechschoolWeb.PageLive.Home do
  use TechschoolWeb, :live_view

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
    |> ok()
  end
end
