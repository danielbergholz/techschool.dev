defmodule TechschoolWeb.BootcampLive.Show do
  use TechschoolWeb, :live_view

  alias Techschool.Bootcamps
  alias Techschool.Lessons.Lesson
  alias TechschoolWeb.OnlineUsersCounter

  embed_templates "components/*"

  attr :lesson, Lesson, required: true
  attr :locale, :string, required: true
  attr :navigate, :string, required: true
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the container"
  def lesson_card(assigns)

  @impl true
  def mount(params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Techschool.PubSub, OnlineUsersCounter.online_users_topic())

      OnlineUsersCounter.track_online_user()
    end

    bootcamp = Bootcamps.get_bootcamp_by_slug!(params["slug"])
    locale = socket.assigns.locale

    page_description =
      if locale == "pt", do: bootcamp.description_pt, else: bootcamp.description_en

    socket
    |> assign(:page_title, "#{bootcamp.name} | TechSchool")
    |> assign(
      :page_description,
      page_description
    )
    |> assign(:bootcamp, bootcamp)
    |> ok()
  end

  @impl true
  def handle_info(%Phoenix.Socket.Broadcast{} = _event, socket) do
    {:noreply, assign(socket, :online_users_count, OnlineUsersCounter.get_online_users_count())}
  end

  def build_lesson_url(locale, lesson) do
    cond do
      lesson.language_names != "" ->
        "/#{locale}/courses?language=#{lesson.language_names |> String.downcase()}"

      lesson.framework_names != "" ->
        "/#{locale}/courses?framework=#{lesson.framework_names |> String.downcase()}"

      lesson.tool_names != "" ->
        "/#{locale}/courses?tool=#{lesson.tool_names |> String.downcase()}"

      lesson.fundamentals_names != "" ->
        "/#{locale}/courses?fundamentals=#{lesson.fundamentals_names |> String.downcase()}"

      true ->
        "/#{locale}/courses"
    end
  end
end
