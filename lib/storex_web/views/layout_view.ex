defmodule StorexWeb.LayoutView do
  use StorexWeb, :view

  alias StorexWeb.Plugs

  def items_count(conn) do
    Plugs.ItemsCount.get(conn)
  end
end
