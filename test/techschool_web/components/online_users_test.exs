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

      assert rendered_component_html =~ "1"
      assert rendered_component_html =~ "user online"
      assert rendered_component_html =~ "md:inline hidden"

      assigns = %{count: 2}

      rendered_component_html = render_component(&OnlineUsers.show_online_users/1, assigns)

      assert rendered_component_html =~ "2"
      assert rendered_component_html =~ "users online"
      assert rendered_component_html =~ "md:inline hidden"
    end
  end
end
