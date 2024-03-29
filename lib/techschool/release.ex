defmodule Techschool.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  @app :techschool

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def reset_db, do: Techschool.Helpers.ResetDb.call()

  def seed do
    Techschool.Helpers.Seed.call(get_data_path())
  end

  def re_seed do
    Techschool.Helpers.ReSeed.call(get_data_path())
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end

  defp get_data_path do
    case :code.priv_dir(:techschool) do
      {:error, _} -> "Could not find :techschool priv directory"
      priv_path -> "#{priv_path}/repo/data"
    end
  end
end
