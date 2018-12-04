defmodule StorexWeb.WatchController do
  use StorexWeb, :controller
  import Storex.Util
  alias Storex.Media.Video
  alias Storex.Repo
  alias StorexWeb.Plugs

  plug :ensure_current_user

#  def show(%{req_headers: headers} = conn, %{"id" => id}) do
    def show(conn, %{"id" => id}) do

      video = Repo.get!(Video, id)
#    send_video(conn, headers, video)
      render(conn, "show.html", video: video)

  end


  defp ensure_current_user(conn, _opts) do
    if Plugs.CurrentUser.get(conn) do
      conn
    else
      conn
      |> put_flash(:error, "Nice try")
      |> redirect(to: session_path(conn, :new))
    end
  end

end
