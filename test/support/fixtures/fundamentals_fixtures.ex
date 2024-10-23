defmodule Techschool.FundamentalsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Techschool.Fundamentals` context.
  """

  @doc """
  Generate a unique fundamental name.
  """
  def unique_fundamental_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a fundamental.
  """
  def fundamental_fixture(attrs \\ %{}) do
    {:ok, fundamental} =
      attrs
      |> Enum.into(%{
        name: unique_fundamental_name(),
        icon_name: "some icon_name"
      })
      |> Techschool.Fundamentals.create_fundamental()

    fundamental
  end
end
