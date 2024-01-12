defmodule Techschool.Channels do
  @moduledoc """
  The Channels context.
  """

  import Ecto.Query, warn: false
  alias Techschool.Repo

  alias Techschool.Channels.Channel

  @doc """
  Returns the list of channels.

  ## Examples

      iex> list_channels()
      [%Channel{}, ...]

  """
  def list_channels do
    Repo.all(Channel) |> Enum.map(&add_channel_url/1)
  end

  @doc """
  Gets a single channel.

  Raises `Ecto.NoResultsError` if the Channel does not exist.

  ## Examples

      iex> get_channel!(123)
      %Channel{}

      iex> get_channel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_channel!(id), do: Repo.get!(Channel, id) |> add_channel_url()

  def add_channel_url(%Channel{} = channel) do
    Map.put(channel, :url, generate_channel_url(channel.youtube_channel_id))
  end

  defp generate_channel_url(youtube_channel_id) do
    "https://www.youtube.com/channel/#{youtube_channel_id}"
  end

  @doc """
  Creates a channel.

  ## Examples

      iex> create_channel(%{field: value})
      {:ok, %Channel{}}

      iex> create_channel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_channel(attrs \\ %{}) do
    %Channel{}
    |> Channel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a channel.

  Raises `Ecto.InvalidChangesetError` for invalid channel.

  ## Examples

      iex> create_channel!(%{field: value})
      %Channel{}

      iex> create_channel!(%{field: bad_value})
      ** (Ecto.InvalidChangesetError)

  """
  def create_channel!(attrs \\ %{}) do
    %Channel{}
    |> Channel.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Deletes a channel.

  ## Examples

      iex> delete_channel(channel)
      {:ok, %Channel{}}

      iex> delete_channel(channel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_channel(%Channel{} = channel) do
    Repo.delete(channel)
  end
end
