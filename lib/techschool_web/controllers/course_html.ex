defmodule TechschoolWeb.CourseHTML do
  use TechschoolWeb, :html

  embed_templates "course_html/*"
  embed_templates "course_html/components/*"

  attr :course, :map, required: true
  def course_card(assigns)
end
