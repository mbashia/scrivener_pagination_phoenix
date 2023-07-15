defmodule Instagram.Repo do
  use Ecto.Repo,
    otp_app: :instagram,
    adapter: Ecto.Adapters.MyXQL
  use Scrivener, page_size: 4
end
