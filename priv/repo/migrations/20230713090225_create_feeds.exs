defmodule Instagram.Repo.Migrations.CreateFeeds do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      add :title, :string
      add :body, :text

      timestamps()
    end
  end
end
