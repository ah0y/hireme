defmodule StorexWeb.CartController do
  use StorexWeb, :controller
  
  alias StorexWeb.Plugs
  alias Storex.Sales
  alias Storex.Media.Store

  def show(conn, _params) do
    cart = Plugs.Cart.get(conn)
    items = Sales.list_line_items(cart)
    total = Sales.line_items_total_price(items)
    render conn, "show.html", items: items, total: total
  end

  def create(conn, %{"video_id" => video_id}) do
    cart = Plugs.Cart.get(conn)
    video = Store.get_video(video_id)
    Sales.add_video_to_cart(video, cart)

    redirect(conn, to: cart_path(conn, :show))
  end

  def delete(conn, %{"video_id" => video_id}) do
    cart = Plugs.Cart.get(conn)
    video = Store.get_video(video_id)
    Sales.remove_video_from_cart(video, cart)

    redirect(conn, to: cart_path(conn, :show))
  end
end