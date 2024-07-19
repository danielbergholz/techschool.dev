defmodule TechschoolWeb.OnlineUsersCounter do
  @moduledoc """
  This module provides topics shared among the application
  """

  alias TechschoolWeb.Presence

  require Logger

  @online_users_topic "online_users_topic"

  def online_users_topic, do: @online_users_topic

  def track_online_user do
    {:ok, _ref} =
      case Presence.track(
             self(),
             @online_users_topic,
             "user:#{Ecto.UUID.generate()}",
             %{}
           ) do
        {:ok, ref} ->
          {:ok, ref}

        _ ->
          Logger.warning("Not possible to track online user")
      end
  end

  def get_online_users_count do
    @online_users_topic
    |> Presence.list()
    |> map_size()
  end
end
