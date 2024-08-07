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
               ~s(<div id=\"online_users_count\" class=\"relative inline-flex opacity-100 transition-opacity duration-300\" aria-label=\"Number of online users using TechSchool\">\n  <p class=\"px-4 py-2 font-semibold text-sm rounded-md text-green bg-slate-800\">\n    1 user online\n  </p>\n  <span class=\"flex absolute h-3 w-3 top-0 right-0 -mt-1 -mr-1\">\n    <span class=\"animate-ping absolute inline-flex h-full w-full rounded-full bg-green opacity-75\">\n    </span>\n    <span class=\"relative inline-flex rounded-full h-3 w-3 bg-green\"></span>\n  </span>\n</div>)

      assigns = %{count: 2}

      rendered_component_html = render_component(&OnlineUsers.show_online_users/1, assigns)

      assert rendered_component_html =~
               ~s(<div id=\"online_users_count\" class=\"relative inline-flex opacity-100 transition-opacity duration-300\" aria-label=\"Number of online users using TechSchool\">\n  <p class=\"px-4 py-2 font-semibold text-sm rounded-md text-green bg-slate-800\">\n    2 users online\n  </p>\n  <span class=\"flex absolute h-3 w-3 top-0 right-0 -mt-1 -mr-1\">\n    <span class=\"animate-ping absolute inline-flex h-full w-full rounded-full bg-green opacity-75\">\n    </span>\n    <span class=\"relative inline-flex rounded-full h-3 w-3 bg-green\"></span>\n  </span>\n</div>)
    end
  end
end
