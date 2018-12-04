defmodule Storex.Media.Store do
  alias Storex.Repo
  alias Storex.Media.Video

  def list_videos() do
    Repo.all(Video)
  end

  def get_video(id) do
    Repo.get(Video, id)
  end

  def create_video(attrs \\ %{}) do
    %Video{}
      |> Video.changeset(attrs)
      |> Repo.insert()
  end

  def change_video(video \\ %Video{}) do
    Video.changeset(video, %{})
  end

  def update_video(video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  def delete_Video(video) do
    Repo.delete(video)
  end
end