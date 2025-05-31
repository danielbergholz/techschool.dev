defmodule TechschoolWeb.Components.Layouts.NavbarLive do
  use TechschoolWeb, :live_component

  alias TechschoolWeb.OnlineUsersCounter

  @impl true
  def mount(socket) do
    {:ok, assign(socket, :online_users_count, 0)}
  end

  @impl true
  def update(assigns, socket) do
    socket = assign(socket, assigns)

    if connected?(socket) do
      Phoenix.PubSub.subscribe(Techschool.PubSub, OnlineUsersCounter.online_users_topic())
      OnlineUsersCounter.track_online_user()
    end

    {:ok, assign(socket, :online_users_count, OnlineUsersCounter.get_online_users_count())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <nav class="text-xl md:text-2xl container-l1 flex justify-between items-center py-3 md:py-4">
      <.link navigate={~p"/#{@locale}"} class="flex items-center">
        <.custom_icon name="logo" class="w-5 md:w-6" />
        <h1 class="font-extrabold ml-2 hidden md:block">
          TechSchool
        </h1>
      </.link>
      <div class="flex items-center justify-center gap-4">
        <.link navigate={~p"/#{@locale}/courses"} class="font-bold hover:underline decoration-green">
          {gettext("Courses")}
        </.link>
        <p class="text-green mx-2">/</p>
        <.link navigate={~p"/#{@locale}/bootcamps"} class="font-bold hover:underline decoration-green">
          Bootcamps
        </.link>
        <.show_online_users count={@online_users_count} />
      </div>
    </nav>
    """
  end
end
