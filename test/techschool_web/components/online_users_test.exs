defmodule TechschoolWeb.OnlineUsersTest do
  use TechschoolWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias TechschoolWeb.OnlineUsers

  describe "show_online_users/1" do
    test "do not render component when count is 0 (edge case)" do
      assigns = %{count: 0}

      rendered_component_html = render_component(&OnlineUsers.show_online_users/1, assigns)

      assert rendered_component_html =~ ""
    end

    test "renders online users count singular and plural form" do
      assigns = %{count: 1}

      rendered_component_html = render_component(&OnlineUsers.show_online_users/1, assigns)

      assert rendered_component_html =~
               ~s(<span id=\"online_users_count\" class=\"mt-2 relative inline-flex\">\n  <button type=\"button\" class=\"inline-flex items-center px-4 py-2 font-semibold leading-6 text-sm shadow rounded-md text-green bg-white dark:bg-slate-800 transition ease-in-out duration-150 cursor-not-allowed ring-1 ring-slate-900/10 dark:ring-slate-200/20\" disabled=\"\">\n    1 online user\n  </button>\n  <span class=\"flex absolute h-3 w-3 top-0 right-0 -mt-1 -mr-1\">\n    <span class=\"animate-ping absolute inline-flex h-full w-full rounded-full bg-green opacity-75\">\n    </span>\n    <span class=\"relative inline-flex rounded-full h-3 w-3 bg-green\"></span>\n  </span>\n</span>)

      assigns = %{count: 2}

      rendered_component_html = render_component(&OnlineUsers.show_online_users/1, assigns)

      assert rendered_component_html =~
               ~s(<span id=\"online_users_count\" class=\"mt-2 relative inline-flex\">\n  <button type=\"button\" class=\"inline-flex items-center px-4 py-2 font-semibold leading-6 text-sm shadow rounded-md text-green bg-white dark:bg-slate-800 transition ease-in-out duration-150 cursor-not-allowed ring-1 ring-slate-900/10 dark:ring-slate-200/20\" disabled=\"\">\n    2 online users\n  </button>\n  <span class=\"flex absolute h-3 w-3 top-0 right-0 -mt-1 -mr-1\">\n    <span class=\"animate-ping absolute inline-flex h-full w-full rounded-full bg-green opacity-75\">\n    </span>\n    <span class=\"relative inline-flex rounded-full h-3 w-3 bg-green\"></span>\n  </span>\n</span>)
    end
  end
end
