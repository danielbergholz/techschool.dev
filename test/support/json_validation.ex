defmodule Techschool.JSONValidator do
  @moduledoc """
  This module is used to validate the priv/repo/data files.
  """
  defmacro __using__(opts) do
    path = opts[:path]
    types = opts[:types]
    required = opts[:required]

    quote do
      import Ecto.Changeset

      def get_json() do
        unquote(path)
        |> File.read!()
        |> Jason.decode!(keys: :atoms)
      end

      def as_changeset(item) do
        keys = Map.keys(unquote(types))
        required = unquote(required)

        required = if(required, do: required, else: keys)

        {%{}, unquote(types)}
        |> cast(item, keys)
        |> validate_required(required)
      end

      def validate(item) do
        assert %{valid?: true} = as_changeset(item)
      end

      defoverridable validate: 1
    end
  end
end
