defmodule Storex.Repo.Migrations.AddOrderIdToSalesLineItemsTable do
  use Ecto.Migration

  def change do
    alter table(:sales_line_items) do
      add :order_id, references(:sales_orders, on_delete: :delete_all)
    end

    create index(:sales_line_items, [:order_id])
  end  
end
