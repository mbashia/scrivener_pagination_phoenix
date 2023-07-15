defmodule Instagram.Feeds.Feed do
  use Ecto.Schema
  import Ecto.Changeset
  alias Instagram.Messages.Message

  schema "feeds" do
    field :body, :string
    field :title, :string
    has_many :messages, Message


    timestamps()
  end

  @doc false
  def changeset(feed, attrs) do
    feed
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
