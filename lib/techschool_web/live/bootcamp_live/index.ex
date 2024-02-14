defmodule TechschoolWeb.BootcampLive.Index do
  use TechschoolWeb, :live_view

  alias Techschool.Bootcamps
  alias Techschool.Bootcamps.Bootcamp

  embed_templates "components/*"

  attr :bootcamp, Bootcamp, required: true
  attr :locale, :string, required: true
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the container"
  def bootcamp_card(assigns)

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> assign(:page_title, "Bootcamps | TechSchool")
    |> assign(
      :page_description,
      gettext(
        "TechSchool offers a variety of bootcamps to help you learn the skills you need to start a new career in tech."
      )
    )
    |> stream(:bootcamps, Bootcamps.list_bootcamps(), reset: true)
    |> ok()
  end
end
