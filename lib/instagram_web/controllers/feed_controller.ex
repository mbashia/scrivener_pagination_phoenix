defmodule InstagramWeb.FeedController do
  use InstagramWeb, :controller

  alias Instagram.Feeds
  alias Instagram.Feeds.Feed
  alias Instagram.Messages.Message
  alias Instagram.Repo
  import Ecto.Query, warn: false


  def index(conn, params) do
    IO.inspect(conn.params)
    IO.write("conn params above")
    query = from(f in Feed,  where: f.title == "this is a new feed",select: f)
    page = query
              |>Repo.paginate(params )
    changeset = Feeds.change_feed(%Feed{})
    IO.inspect(changeset)

    render(conn, "index.html", feeds: page.entries, changeset: changeset, page: page)
  end

  def new(conn, _params) do
    changeset = Feeds.change_feed(%Feed{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feed" => feed_params}) do
    case Feeds.create_feed(feed_params) do
      {:ok, feed} ->
        conn
        |> put_flash(:info, "Feed created successfully.")
        |> redirect(to: Routes.feed_path(conn, :show, feed))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    changeset = Message.changeset(%Message{},%{})
    render(conn, "show.html", feed: feed, changeset: changeset )
  end

  def edit(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    changeset = Feeds.change_feed(feed)
    render(conn, "edit.html", feed: feed, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feed" => feed_params}) do
    feed = Feeds.get_feed!(id)

    case Feeds.update_feed(feed, feed_params) do
      {:ok, feed} ->
        conn
        |> put_flash(:info, "Feed updated successfully.")
        |> redirect(to: Routes.feed_path(conn, :show, feed))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", feed: feed, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    {:ok, _feed} = Feeds.delete_feed(feed)

    conn
    |> put_flash(:info, "Feed deleted successfully.")
    |> redirect(to: Routes.feed_path(conn, :index))
  end

  def add_message(conn, %{"message" => message_params, "feed_id" => feed_id}) do
    feed =
      feed_id
      |> Feeds.get_feed!()
      |> Repo.preload(:messages)
    case Feeds.add_message(feed_id, message_params) do
      {:ok, _message} ->
        conn
        |> put_flash(:info, "message added :)")
        |> redirect(to: Routes.feed_path(conn, :show, feed))
      {:error, _error} ->
        conn
        |> put_flash(:error, "message not added :(")
        |> redirect(to: Routes.feed_path(conn, :show, feed))
    end

  end





# def search(conn,"feed" => %{"search" => search_params}) do
#   IO.write("conn_params")
#   IO.inspect(conn.params)
#   feeds = Feeds.search(search_params)
#  changeset = Feeds.change_feed(%Feed{})

#  conn
#  |> put_flash(:danger, "Feed search not successfully.")
#  |> render( "index.html", feeds: [], changeset: changeset)

#  end

 end


#  def search(conn, %{"feed" => %{"search" => search_params}}) do
#   feeds = Feedback.search_me(search_params)
#   search_changeset= Feedback.change_feed(%Feed{})
#   case feeds do
#   [] ->
#   conn
#   |> put_flash(:danger, "Feed search not successfully.")
#   |> render( "index.html", feeds: [], search_changeset: search_changeset)
#   _ ->
#   conn

#   |> put_flash(:info, "Feed search successfully.")

#   |> render( "index.html", feeds: feeds, search_changeset: search_changeset)

#   end

#   end
