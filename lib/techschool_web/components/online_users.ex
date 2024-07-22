defmodule TechschoolWeb.OnlineUsers do
  @moduledoc """
  Component to show the count of online users.
  """
  use Phoenix.Component

  attr :count, :integer, required: true

  def show_online_users(%{count: 0} = assigns) do
    ~H"""
    """
  end

  def show_online_users(%{count: 1} = assigns) do
    ~H"""
    <span id="online_users_count" class="mt-2 relative inline-flex">
      <button
        type="button"
        class="inline-flex items-center px-4 py-2 font-semibold leading-6 text-sm shadow rounded-md text-green bg-white dark:bg-slate-800 transition ease-in-out duration-150 cursor-not-allowed ring-1 ring-slate-900/10 dark:ring-slate-200/20"
        disabled=""
      >
        <%= @count %> online user
      </button>
      <span class="flex absolute h-3 w-3 top-0 right-0 -mt-1 -mr-1">
        <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-green opacity-75">
        </span>
        <span class="relative inline-flex rounded-full h-3 w-3 bg-green"></span>
      </span>
    </span>
    """
  end

  def show_online_users(assigns) do
    ~H"""
    <span id="online_users_count" class="mt-2 relative inline-flex">
      <button
        type="button"
        class="inline-flex items-center px-4 py-2 font-semibold leading-6 text-sm shadow rounded-md text-green bg-white dark:bg-slate-800 transition ease-in-out duration-150 cursor-not-allowed ring-1 ring-slate-900/10 dark:ring-slate-200/20"
        disabled=""
      >
        <%= @count %> online users
      </button>
      <span class="flex absolute h-3 w-3 top-0 right-0 -mt-1 -mr-1">
        <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-green opacity-75">
        </span>
        <span class="relative inline-flex rounded-full h-3 w-3 bg-green"></span>
      </span>
    </span>
    """
  end
end
