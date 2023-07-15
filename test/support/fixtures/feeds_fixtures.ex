defmodule Instagram.FeedsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Instagram.Feeds` context.
  """

  @doc """
  Generate a feed.
  """
  def feed_fixture(attrs \\ %{}) do
    {:ok, feed} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> Instagram.Feeds.create_feed()

    feed
  end
end
