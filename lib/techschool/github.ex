defmodule Techschool.GitHub do
  @moduledoc """
  Module for interacting with the GitHub API.
  """

  @base_url "https://api.github.com"

  def get_contributors() do
    url = "#{@base_url}/repos/danielbergholz/techschool.dev/contributors"

    case Cachex.get(:techschool_cache, "github_contributors") do
      # Cache miss
      {:ok, nil} ->
        contributors = fetch_contributors(url)
        Cachex.put(:techschool_cache, "github_contributors", contributors, ttl: :timer.hours(24))
        contributors

      # Cache hit
      {:ok, contributors} ->
        contributors

      {:error, _} ->
        []
    end
  end

  defp fetch_contributors(url) do
    case Req.get(url) do
      {:ok, response} ->
        filter_bot_contributors(response.body)

      {:error, _} ->
        []
    end
  end

  defp filter_bot_contributors(contributors) do
    contributors |> Enum.reject(&(&1["type"] == "Bot"))
  end
end
