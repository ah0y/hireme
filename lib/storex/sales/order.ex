defmodule Storex.Sales.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Sales.Order
  alias Storex.Sales.LineItem
  alias Storex.Accounts.User


  schema "sales_orders" do
    belongs_to :user, User, type: :binary_id
    has_many :line_items, LineItem
    field :address, :string

    timestamps()
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [:address])
    |> validate_required([:address])
  end
end
