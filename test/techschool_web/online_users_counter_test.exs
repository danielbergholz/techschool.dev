defmodule TechschoolWeb.OnlineUsersCounterTest do
  use Techschool.DataCase
  alias TechschoolWeb.OnlineUsersCounter

  describe "track_online_user/0" do
    test "must track a new user" do
      assert {:ok, _} = OnlineUsersCounter.track_online_user()
    end
  end

  describe "get_online_users_count/0" do
    test "return 0" do
      assert OnlineUsersCounter.get_online_users_count() == 0
    end

    test "must return 2" do
      OnlineUsersCounter.track_online_user()
      OnlineUsersCounter.track_online_user()

      assert OnlineUsersCounter.get_online_users_count() == 2
    end
  end
end
