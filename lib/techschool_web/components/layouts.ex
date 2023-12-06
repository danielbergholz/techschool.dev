defmodule TechschoolWeb.Layouts do
  use TechschoolWeb, :html

  embed_templates "layouts/*"

  def navbar(assigns) do
    ~H"""
    <nav class="text-xl md:text-2xl container-l1 flex justify-between items-center py-3 md:py-4">
      <.link navigate="/" class="flex items-center">
        <img src={~p"/images/logo.svg"} alt="TechSchool Logo" class="w-5 md:w-7" />
        <h1 class="font-extrabold ml-2">
          TechSchool
        </h1>
      </.link>
      <.link navigate="/cursos" class="font-bold">
        <%= gettext("Courses") %>
      </.link>
    </nav>
    """
  end
end
