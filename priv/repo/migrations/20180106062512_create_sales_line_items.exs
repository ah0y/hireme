defmodule Storex.Repo.Migrations.CreateSalesLineItems do
  use Ecto.Migration

  def change do
    create table(:sales_line_items) do
      add :quantity, :integer, default: 0
      add :video_id, references(:videos, on_delete: :delete_all, type: :uuid)
      add :cart_id, references(:sales_carts, on_delete: :delete_all)

      timestamps()
    end

    create index(:sales_line_items, [:video_id])
    create index(:sales_line_items, [:cart_id])
  end
end
