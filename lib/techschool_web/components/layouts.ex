defmodule TechschoolWeb.Layouts do
  use TechschoolWeb, :html

  embed_templates "layouts/*"
  embed_templates "layouts/components/*"

  attr :locale, :string, required: true

  def navbar(assigns)
end
