defmodule Techschool.Repo.Migrations.AddFundamentalsNamesToLessons do
  use Ecto.Migration

  def change do
    alter table(:lessons) do
      add :fundamentals_names, :string
    end
  end
end
