defmodule Techschool.FrameworksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Techschool.Frameworks` context.
  """

  @doc """
  Generate a unique framework name.
  """
  def unique_framework_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a framework.
  """
  def framework_fixture(attrs \\ %{}) do
    {:ok, framework} =
      attrs
      |> Enum.into(%{
        icon_name: "some icon_name",
        name: unique_framework_name()
      })
      |> Techschool.Frameworks.create_framework()

    framework
  end
end
