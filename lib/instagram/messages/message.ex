defmodule Instagram.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Instagram.Feeds.Feed

  schema "messages" do
    field :content, :string
    field :name, :string
    belongs_to :feed, Feed


    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :content, :feed_id])
    |> validate_required([:name, :content, :feed_id])
  end
end
