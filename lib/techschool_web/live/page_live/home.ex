defmodule TechschoolWeb.PageLive.Home do
  use TechschoolWeb, :live_view

  alias Techschool.GitHub
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
      Phoenix.PubSub.subscribe(Techschool.PubSub, "online_users")

      OnlineUsersCounter.track_online_user()
    end

    socket
    |> assign_async(:github_contributors, fn ->
      {:ok, %{github_contributors: GitHub.get_contributors()}}
    end)
    |> assign(:page_title, "TechSchool")
    |> assign(:online_users, 0)
    |> ok()
  end

  @impl true
  def handle_info(%Phoenix.Socket.Broadcast{} = _event, socket) do
    {:noreply, assign(socket, :online_users, OnlineUsersCounter.get_online_users_count())}
  end
end
