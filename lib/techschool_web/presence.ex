defmodule TechschoolWeb.Presence do
  @moduledoc """
  Module TechschoolWeb.Presence
  """

  use Phoenix.Presence,
    otp_app: :techschool,
    pubsub_server: Techschool.PubSub
end
