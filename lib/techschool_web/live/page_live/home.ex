defmodule TechschoolWeb.PageLive.Home do
  use TechschoolWeb, :live_view

  alias Techschool.{GitHub, Courses}
  alias TechschoolWeb.OnlineUsersCounter

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
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Techschool.PubSub, OnlineUsersCounter.online_users_topic())
      OnlineUsersCounter.track_online_user()
    end

    socket
    |> assign(:page_title, "TechSchool")
    |> assign(:online_users_count, 0)
    |> assign(:last_updated, Courses.last_updated())
    |> assign_async(:github_contributors, fn ->
      {:ok, %{github_contributors: GitHub.get_contributors()}}
    end)
    |> ok()
  end

  @impl true
  def handle_info(%Phoenix.Socket.Broadcast{} = _event, socket) do
    socket
    |> assign(:online_users_count, OnlineUsersCounter.get_online_users_count())
    |> noreply()
  end
end
