defmodule TechschoolWeb.PageHTML do
  use TechschoolWeb, :html

  embed_templates "page_html/*"
  embed_templates "page_html/components/*"

  attr :inverse_locale, :string, required: true

  def translate_button(assigns)

  defp inverse_locale(locale) do
    case locale do
      "pt" -> "en"
      "en" -> "pt"
    end
  end
end
