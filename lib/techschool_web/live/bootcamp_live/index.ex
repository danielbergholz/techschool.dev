defmodule TechschoolWeb.BootcampLive.Index do
  use TechschoolWeb, :live_view

  alias Techschool.Bootcamps
  alias Techschool.Bootcamps.Bootcamp
  alias TechschoolWeb.OnlineUsersCounter

  embed_templates "components/*"

  attr :bootcamp, Bootcamp, required: true
  attr :locale, :string, required: true
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the container"
  def bootcamp_card(assigns)

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Techschool.PubSub, OnlineUsersCounter.online_users_topic())

      OnlineUsersCounter.track_online_user()
    end

    socket
    |> assign(:page_title, "Bootcamps | TechSchool")
    |> assign(
      :page_description,
      gettext(
        "TechSchool offers a variety of bootcamps to help you learn the skills you need to start a new career in tech."
      )
    )
    |> assign(:online_users_count, 0)
    |> stream(:bootcamps, Bootcamps.list_bootcamps(), reset: true)
    |> ok()
  end

  @impl true
  def handle_info(%Phoenix.Socket.Broadcast{} = _event, socket) do
    socket
    |> assign(:online_users_count, OnlineUsersCounter.get_online_users_count())
    |> noreply()
  end
end
