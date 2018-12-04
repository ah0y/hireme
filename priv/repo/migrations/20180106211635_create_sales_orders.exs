defmodule Storex.Repo.Migrations.CreateSalesOrders do
  use Ecto.Migration

  def change do
    create table(:sales_orders) do
      add :first, :string
      add :last, :string
      add :cc, :string
      add :exp, :string
      add :zip, :string
      add :state, :string
      add :city, :string
      add :address, :string
      add :user_id, references(:accounts_users, on_delete: :delete_all, type: :uuid)

      timestamps()
    end

    create index(:sales_orders, [:user_id])
  end
end
