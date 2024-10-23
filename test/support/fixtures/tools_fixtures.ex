defmodule Techschool.ToolsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Techschool.Tools` context.
  """

  @doc """
  Generate a unique tool name.
  """
  def unique_tool_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a tool.
  """
  def tool_fixture(attrs \\ %{}) do
    {:ok, tool} =
      attrs
      |> Enum.into(%{
        name: unique_tool_name(),
        icon_name: "some icon_name"
      })
      |> Techschool.Tools.create_tool()

    tool
  end
end
