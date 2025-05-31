defmodule TechschoolWeb.Hooks.OnlineUsersCounter do
  @moduledoc """
  LiveView hook for tracking online users across all pages.
  """

  import Phoenix.Component
  import Phoenix.LiveView

  alias TechschoolWeb.OnlineUsersCounter

  def on_mount(:default, _params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Techschool.PubSub, OnlineUsersCounter.online_users_topic())
      OnlineUsersCounter.track_online_user()
    end

    socket =
      socket
      |> assign(:online_users_count, OnlineUsersCounter.get_online_users_count())
      |> attach_hook(__MODULE__, :handle_info, &handle_online_users_info/2)

    {:cont, socket}
  end

  defp handle_online_users_info(%Phoenix.Socket.Broadcast{} = _event, socket) do
    {:halt, assign(socket, :online_users_count, OnlineUsersCounter.get_online_users_count())}
  end

  defp handle_online_users_info(_event, socket) do
    {:cont, socket}
  end
end
