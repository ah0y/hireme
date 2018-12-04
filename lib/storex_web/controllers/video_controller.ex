defmodule StorexWeb.VideoController do
  use StorexWeb, :controller
  use Rummage.Phoenix.Controller

  import Storex.Util, only: [build_video_path: 1]
  alias Storex.Media
  alias Storex.Media.Video
  alias Storex.Repo

  plug StorexWeb.Plugs.AdminOnly when action not in [:index, :show, :purchased]


  def index(conn, params) do
    videos = Media.list_videos()

    {query, rummage} = Video
    |> Video.rummage(params["rummage"])

    videos = Repo.all(query)

    render(conn, "index.html", videos: videos, rummage: rummage)
  end

  def purchased(conn, _params) do
    videos = Media.show_purchased(conn.assigns.current_user.id)
    render(conn, "purchased.html", videos: videos)
  end

  def new(conn, _params) do
    changeset = Media.change_video(%Video{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" =>  video_params} ) do
    file_uuid = UUID.uuid4(:hex)
    video_filename = video_params["video_file"].filename
    unique_filename = "#{file_uuid}.#{video_filename}"

    {:ok, video_binary} = File.read(video_params["video_file"].path)
    bucket_name = System.get_env("BUCKET_NAME")
    video =
      ExAws.S3.put_object(bucket_name, unique_filename, video_binary)
      |> ExAws.request!
    # build the video url and add to the params to be stored
    updated_params =
#      put_in(video_params["video_file"].path, "https://#{bucket_name}.s3.amazonaws.com/#{bucket_name}/#{unique_filename}")
      Map.put(video_params, "s3_url",  "https://#{bucket_name}.s3.amazonaws.com/#{bucket_name}/#{unique_filename}")

    changeset = Video.changeset(%Video{}, updated_params)
    require IEx; IEx.pry
    case Repo.insert(changeset) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video uploaded successfully!")
        |> redirect(to: video_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
#    case Media.create_video(updated_params) do
#      {:ok, test} ->
#        persist_file(video, video_params["video_file"])
#
#
#        conn
#        |> put_flash(:info, "Video created successfully.")
#        |> redirect(to: video_path(conn, :show, video))
#      {:error, %Ecto.Changeset{} = changeset} ->
#        render(conn, "new.html", changeset: changeset)
#    end
  end

  defp persist_file(video, %{path: temp_path}) do
    video_path = build_video_path(video)
    unless File.exists?(video_path) do
      video_path |> Path.dirname() |> File.mkdir_p()
      File.copy!(temp_path, video_path)
    end
  end

  def show(conn, %{"id" => id}) do
    video = Media.get_video!(id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    video = Media.get_video!(id)
    changeset = Media.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Media.get_video!(id)

    case Media.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Media.get_video!(id)
    {:ok, _video} = Media.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: video_path(conn, :index))
  end
end
