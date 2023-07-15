defmodule Instagram.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :name, :string
      add :content, :text
      add :feed_id, references(:feeds, on_delete: :nothing)

      timestamps()
    end

    create index(:messages, [:feed_id])
  end
end
