defmodule Techschool.PlatformsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Techschool.Platforms` context.
  """

  @doc """
  Generate a unique platform name.
  """
  def unique_platform_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a platform.
  """
  def platform_fixture(attrs \\ %{}) do
    {:ok, platform} =
      attrs
      |> Enum.into(%{
        description_en: "some description_en",
        description_pt: "some description_pt",
        image_url: "some image_url",
        name: unique_platform_name(),
        url: "some url"
      })
      |> Techschool.Platforms.create_platform()

    Techschool.Platforms.get_platform!(platform.id)
  end
end
