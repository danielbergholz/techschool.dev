defmodule TechschoolWeb.OnlineUsers do
  @moduledoc """
  Component to show the count of online users.
  """
  use Phoenix.Component
  use Gettext, backend: TechschoolWeb.Gettext

  attr :count, :integer, required: true
  attr :class, :string, default: ""

  def show_online_users(%{count: 0} = assigns) do
    ~H"""
    <div
      id="online_users_count"
      class={["relative inline-flex opacity-75 ", @class]}
      aria-label="Number of online users using TechSchool"
    >
      <p class="px-2 py-1 md:px-4 md:py-2 font-semibold text-sm rounded-md text-green bg-slate-800">
        1
        <span class="md:inline hidden">
          {gettext("user")} online
        </span>
      </p>
    </div>
    """
  end

  def show_online_users(assigns) do
    ~H"""
    <div
      id="online_users_count"
      class={["relative inline-flex opacity-100 transition-opacity duration-300 ", @class]}
      aria-label="Number of online users using TechSchool"
    >
      <p class="px-2 py-1 md:px-4 md:py-2 font-semibold text-sm rounded-md text-green bg-slate-800">
        {@count}
        <span class="md:inline hidden">
          {gettext("user")}{if @count == 1, do: "", else: "s"} online
        </span>
      </p>
      <span class="flex absolute h-3 w-3 top-0 right-0 -mt-1 -mr-1">
        <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-green opacity-75">
        </span>
        <span class="relative inline-flex rounded-full h-3 w-3 bg-green"></span>
      </span>
    </div>
    """
  end
end
